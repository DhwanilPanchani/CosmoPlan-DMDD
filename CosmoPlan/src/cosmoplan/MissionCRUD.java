package cosmoplan;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class MissionCRUD extends JFrame {
    // Database credentials and connection string
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=CosmoPlan;encrypt=true;trustServerCertificate=true;";
    private static final String USER = "SA";
    private static final String PASSWORD = "Docker@123";

    // UI Components
    private JTextField txtMissionID, txtMissionName, txtMissionStartDate, txtDuration, txtMissionStatus, txtDestination, txtMissionBudget;
    private JButton btnCreate, btnRead, btnUpdate, btnDelete, btnBack;

    public MissionCRUD() {
        // Initialize UI Components
        createUI();

        // Set JFrame properties
        setTitle("Mission Management");
        setSize(500, 300);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    }

    private void createUI() {
        setLayout(new GridLayout(11, 2, 5, 5));

        txtMissionID = new JTextField();
        txtMissionName = new JTextField();
        txtMissionStartDate = new JTextField();
        txtDuration = new JTextField();
        txtMissionStatus = new JTextField();
        txtDestination = new JTextField();
        txtMissionBudget = new JTextField();

        btnCreate = new JButton("Create");
        btnRead = new JButton("Read");
        btnUpdate = new JButton("Update");
        btnDelete = new JButton("Delete");
        JButton btnClear = new JButton("Clear");
        btnBack = new JButton("Back");

        add(new JLabel("Mission ID"));
        add(txtMissionID);
        add(new JLabel("Mission Name"));
        add(txtMissionName);
        add(new JLabel("Start Date (YYYY-MM-DD)"));
        add(txtMissionStartDate);
        add(new JLabel("Duration (days)"));
        add(txtDuration);
        add(new JLabel("Status"));
        add(txtMissionStatus);
        add(new JLabel("Destination"));
        add(txtDestination);
        add(new JLabel("Budget"));
        add(txtMissionBudget);

        add(btnCreate);
        add(btnRead);
        add(btnUpdate);
        add(btnDelete);
        add(btnClear);
        add(btnBack);

        // Event Handling
        btnClear.addActionListener(e -> clearFields());
        btnBack.addActionListener(e -> backToDashboard());
        btnCreate.addActionListener(e -> createMission());
        btnRead.addActionListener(e -> readMission());
        btnUpdate.addActionListener(e -> updateMission());
        btnDelete.addActionListener(e -> deleteMission());
    }
    private void clearFields() {
    txtMissionID.setText("");
    txtMissionName.setText("");
    txtMissionStartDate.setText("");
    txtDuration.setText("");
    txtMissionStatus.setText("");
    txtDestination.setText("");
    txtMissionBudget.setText("");
    }
    private void backToDashboard() {
        Dashboard dashboard = new Dashboard(); // Create an instance of the Dashboard
        dashboard.setVisible(true); // Show the Dashboard window
        dispose(); // Close the current window (AgencyCRUD)
    }

    private void createMission() {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "INSERT INTO Mission (MissionID, MissionName, MissionStartDate, Duration, MissionStatus, Destination, MissionBudget) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, txtMissionID.getText());
            pst.setString(2, txtMissionName.getText());
            pst.setDate(3, Date.valueOf(txtMissionStartDate.getText()));
            pst.setInt(4, Integer.parseInt(txtDuration.getText()));
            pst.setString(5, txtMissionStatus.getText());
            pst.setString(6, txtDestination.getText());
            pst.setDouble(7, Double.parseDouble(txtMissionBudget.getText()));

            pst.executeUpdate();
            JOptionPane.showMessageDialog(this, "Mission created successfully.");
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error creating mission.");
        }
    }

    private void readMission() {
    try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
        String sql = "SELECT * FROM Mission WHERE MissionID = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, txtMissionID.getText());

        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            txtMissionName.setText(rs.getString("MissionName"));
            txtMissionStartDate.setText(rs.getDate("MissionStartDate").toString());
            txtDuration.setText(String.valueOf(rs.getInt("Duration")));
            txtMissionStatus.setText(rs.getString("MissionStatus"));
            txtDestination.setText(rs.getString("Destination"));
            txtMissionBudget.setText(String.valueOf(rs.getDouble("MissionBudget")));
        } else {
            JOptionPane.showMessageDialog(this, "Mission not found.");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        JOptionPane.showMessageDialog(this, "Error reading mission details.");
    }
}

    private void updateMission() {
    try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
        String sql = "UPDATE Mission SET MissionName = ?, MissionStartDate = ?, Duration = ?, MissionStatus = ?, Destination = ?, MissionBudget = ? WHERE MissionID = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, txtMissionName.getText());
        pst.setDate(2, Date.valueOf(txtMissionStartDate.getText()));
        pst.setInt(3, Integer.parseInt(txtDuration.getText()));
        pst.setString(4, txtMissionStatus.getText());
        pst.setString(5, txtDestination.getText());
        pst.setDouble(6, Double.parseDouble(txtMissionBudget.getText()));
        pst.setString(7, txtMissionID.getText());

        int updatedRows = pst.executeUpdate();
        if (updatedRows > 0) {
            JOptionPane.showMessageDialog(this, "Mission updated successfully.");
        } else {
            JOptionPane.showMessageDialog(this, "Mission not found.");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        JOptionPane.showMessageDialog(this, "Error updating mission.");
    }
}

    
    
    private void deleteMission() {
    int confirm = JOptionPane.showConfirmDialog(this, "Are you sure you want to delete this mission?", "Delete Mission", JOptionPane.YES_NO_OPTION);
    if (confirm == JOptionPane.YES_OPTION) {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "DELETE FROM Mission WHERE MissionID = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, txtMissionID.getText());

            int deletedRows = pst.executeUpdate();
            if (deletedRows > 0) {
                JOptionPane.showMessageDialog(this, "Mission deleted successfully.");
                // Clear input fields after deletion
                txtMissionID.setText("");
                txtMissionName.setText("");
                txtMissionStartDate.setText("");
                txtDuration.setText("");
                txtMissionStatus.setText("");
                txtDestination.setText("");
                txtMissionBudget.setText("");
            } else {
                JOptionPane.showMessageDialog(this, "Mission not found.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error deleting mission.");
        }
    }
}


    public static void main(String[] args) {
        try {
            // Set Look and Feel to system default
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            e.printStackTrace();
        }

        SwingUtilities.invokeLater(() -> new MissionCRUD().setVisible(true));
    }
}
