import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class DatabaseGUI extends JFrame {
    private JComboBox<String> tableSelector;
    private JTable dataTable;
    private DefaultTableModel tableModel;
    private Connection connection;

    public DatabaseGUI() {
        // Ρύθμιση GUI
        setTitle("Database GUI");
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setSize(800, 600);
        setLayout(new BorderLayout());

        // Πάνελ επιλογής πίνακα
        JPanel topPanel = new JPanel(new FlowLayout());
        tableSelector = new JComboBox<>();
        JButton loadButton = new JButton("Load Table");
        topPanel.add(new JLabel("Select Table:"));
        topPanel.add(tableSelector);
        topPanel.add(loadButton);
        add(topPanel, BorderLayout.NORTH);

        // Πίνακας δεδομένων
        tableModel = new DefaultTableModel();
        dataTable = new JTable(tableModel);
        add(new JScrollPane(dataTable), BorderLayout.CENTER);

        // Κουμπιά CRUD
        JPanel bottomPanel = new JPanel(new FlowLayout());
        JButton insertButton = new JButton("Insert");
        JButton updateButton = new JButton("Update");
        JButton deleteButton = new JButton("Delete");
        bottomPanel.add(insertButton);
        bottomPanel.add(updateButton);
        bottomPanel.add(deleteButton);
        add(bottomPanel, BorderLayout.SOUTH);

        // Σύνδεση με τη βάση δεδομένων
        connectToDatabase();

        // Φόρτωση ονομάτων πινάκων
        loadTableNames();

        // Χειριστές συμβάντων
        loadButton.addActionListener(e -> loadTableData());
        insertButton.addActionListener(e -> insertData());
        updateButton.addActionListener(e -> updateData());
        deleteButton.addActionListener(e -> deleteData());
    }

    private void connectToDatabase() {
        try {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/SmallDB", "root", "password");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error connecting to database: " + e.getMessage());
            System.exit(1);
        }
    }

    private void loadTableNames() {
        try {
            DatabaseMetaData metaData = connection.getMetaData();
            ResultSet tables = metaData.getTables(null, null, "%", new String[]{"TABLE"});
            while (tables.next()) {
                tableSelector.addItem(tables.getString("TABLE_NAME"));
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error loading table names: " + e.getMessage());
        }
    }

    private void loadTableData() {
        String tableName = (String) tableSelector.getSelectedItem();
        if (tableName == null) return;

        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM " + tableName);
            ResultSetMetaData metaData = resultSet.getMetaData();

            // Ρύθμιση του μοντέλου πίνακα
            int columnCount = metaData.getColumnCount();
            String[] columnNames = new String[columnCount];
            for (int i = 1; i <= columnCount; i++) {
                columnNames[i - 1] = metaData.getColumnName(i);
            }
            tableModel.setColumnIdentifiers(columnNames);

            tableModel.setRowCount(0);
            while (resultSet.next()) {
                Object[] row = new Object[columnCount];
                for (int i = 1; i <= columnCount; i++) {
                    row[i - 1] = resultSet.getObject(i);
                }
                tableModel.addRow(row);
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error loading table data: " + e.getMessage());
        }
    }

    private void insertData() {
        String tableName = (String) tableSelector.getSelectedItem();
        if (tableName == null) return;

        try {
            String columns = "";
            String values = "";
            for (int i = 0; i < tableModel.getColumnCount(); i++) {
                if (i > 0) {
                    columns += ", ";
                    values += ", ";
                }
                columns += tableModel.getColumnName(i);
                values += "?";
            }

            String sql = "INSERT INTO " + tableName + " (" + columns + ") VALUES (" + values + ")";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            for (int i = 0; i < tableModel.getColumnCount(); i++) {
                preparedStatement.setObject(i + 1, JOptionPane.showInputDialog("Enter value for " + tableModel.getColumnName(i) + ":"));
            }
            preparedStatement.executeUpdate();
            loadTableData();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error inserting data: " + e.getMessage());
        }
    }

    private void updateData() {
        int selectedRow = dataTable.getSelectedRow();
        if (selectedRow == -1) {
            JOptionPane.showMessageDialog(this, "Select a row to update.");
            return;
        }

        String tableName = (String) tableSelector.getSelectedItem();
        if (tableName == null) return;

        try {
            String setClause = "";
            for (int i = 0; i < tableModel.getColumnCount(); i++) {
                if (i > 0) setClause += ", ";
                setClause += tableModel.getColumnName(i) + " = ?";
            }

            String sql = "UPDATE " + tableName + " SET " + setClause + " WHERE " + tableModel.getColumnName(0) + " = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            for (int i = 0; i < tableModel.getColumnCount(); i++) {
                preparedStatement.setObject(i + 1, JOptionPane.showInputDialog("Enter new value for " + tableModel.getColumnName(i) + ":"));
            }
            preparedStatement.setObject(tableModel.getColumnCount() + 1, tableModel.getValueAt(selectedRow, 0));
            preparedStatement.executeUpdate();
            loadTableData();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error updating data: " + e.getMessage());
        }
    }

    private void deleteData() {
        int selectedRow = dataTable.getSelectedRow();
        if (selectedRow == -1) {
            JOptionPane.showMessageDialog(this, "Select a row to delete.");
            return;
        }

        String tableName = (String) tableSelector.getSelectedItem();
        if (tableName == null) return;

        try {
            String sql = "DELETE FROM " + tableName + " WHERE " + tableModel.getColumnName(0) + " = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setObject(1, tableModel.getValueAt(selectedRow, 0));
            preparedStatement.executeUpdate();
            loadTableData();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error deleting data: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new DatabaseGUI().setVisible(true));
    }
}
