package cosmoplan;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class LaunchVehicleCRUD extends JFrame {
    // Database credentials and connection string
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=CosmoPlan;encrypt=true;trustServerCertificate=true;";
    private static final String USER = "SA";
    private static final String PASSWORD = "Docker@123";

    // UI Components for LaunchVehicle
    private JTextField txtVehicleID, txtVehicleName, txtVehicleType, txtPayloadCapacity, txtManufacturer, txtMissionID;
    private JButton btnCreate, btnRead, btnUpdate, btnDelete, btnBack;

    public LaunchVehicleCRUD() {
        // Initialize UI Components
        createUI();

        // Set JFrame properties
        setTitle("Launch Vehicle Management");
        setSize(500, 350); // Adjusted for additional fields
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    }

    private void createUI() {
        setLayout(new GridLayout(9, 2, 5, 5)); // Adjusted grid layout for LaunchVehicle fields

        txtVehicleID = new JTextField();
        txtVehicleName = new JTextField();
        txtVehicleType = new JTextField();
        txtPayloadCapacity = new JTextField();
        txtManufacturer = new JTextField();
        txtMissionID = new JTextField();

        btnCreate = new JButton("Create");
        btnRead = new JButton("Read");
        btnUpdate = new JButton("Update");
        btnDelete = new JButton("Delete");
        JButton btnClear = new JButton("Clear");
        btnBack = new JButton("Back");

        add(new JLabel("Vehicle ID"));
        add(txtVehicleID);
        add(new JLabel("Vehicle Name"));
        add(txtVehicleName);
        add(new JLabel("Vehicle Type"));
        add(txtVehicleType);
        add(new JLabel("Payload Capacity"));
        add(txtPayloadCapacity);
        add(new JLabel("Manufacturer"));
        add(txtManufacturer);
        add(new JLabel("Mission ID"));
        add(txtMissionID);

        add(btnCreate);
        add(btnRead);
        add(btnUpdate);
        add(btnDelete);
        add(btnClear);
        add(btnBack);

        // Event Handling
        btnBack.addActionListener(e -> backToDashboard());
        btnClear.addActionListener(e -> clearFields());
        btnCreate.addActionListener(e -> createLaunchVehicle());
        btnRead.addActionListener(e -> readLaunchVehicle());
        btnUpdate.addActionListener(e -> updateLaunchVehicle());
        btnDelete.addActionListener(e -> deleteLaunchVehicle());
    }
    private void clearFields() {
    txtVehicleID.setText("");
    txtVehicleName.setText("");
    txtVehicleType.setText("");
    txtPayloadCapacity.setText("");
    txtManufacturer.setText("");
    txtMissionID.setText("");
    }
    private void backToDashboard() {
        Dashboard dashboard = new Dashboard(); // Create an instance of the Dashboard
        dashboard.setVisible(true); // Show the Dashboard window
        dispose(); // Close the current window (AgencyCRUD)
    }

    
    private void createLaunchVehicle() {
    try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
        String sql = "INSERT INTO LaunchVehicle (VehicleID, VehicleName, VehicleType, PayloadCapacity, Manufacturer, MissionID) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, txtVehicleID.getText());
        pst.setString(2, txtVehicleName.getText());
        pst.setString(3, txtVehicleType.getText());
        pst.setDouble(4, Double.parseDouble(txtPayloadCapacity.getText()));
        pst.setString(5, txtManufacturer.getText());
        pst.setString(6, txtMissionID.getText());

        pst.executeUpdate();
        JOptionPane.showMessageDialog(this, "Launch Vehicle created successfully.");
    } catch (Exception ex) {
        ex.printStackTrace();
        JOptionPane.showMessageDialog(this, "Error creating launch vehicle.");
    }
}


   
    private void readLaunchVehicle() {
    try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
        String sql = "SELECT * FROM LaunchVehicle WHERE VehicleID = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, txtVehicleID.getText());

        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            txtVehicleName.setText(rs.getString("VehicleName"));
            txtVehicleType.setText(rs.getString("VehicleType"));
            txtPayloadCapacity.setText(String.valueOf(rs.getDouble("PayloadCapacity")));
            txtManufacturer.setText(rs.getString("Manufacturer"));
            txtMissionID.setText(rs.getString("MissionID"));
        } else {
            JOptionPane.showMessageDialog(this, "Launch Vehicle not found.");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        JOptionPane.showMessageDialog(this, "Error reading launch vehicle details.");
    }
}


    
    private void updateLaunchVehicle() {
    try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
        String sql = "UPDATE LaunchVehicle SET VehicleName = ?, VehicleType = ?, PayloadCapacity = ?, Manufacturer = ?, MissionID = ? WHERE VehicleID = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, txtVehicleName.getText());
        pst.setString(2, txtVehicleType.getText());
        pst.setDouble(3, Double.parseDouble(txtPayloadCapacity.getText()));
        pst.setString(4, txtManufacturer.getText());
        pst.setString(5, txtMissionID.getText());
        pst.setString(6, txtVehicleID.getText());

        int updatedRows = pst.executeUpdate();
        if (updatedRows > 0) {
            JOptionPane.showMessageDialog(this, "Launch Vehicle updated successfully.");
        } else {
            JOptionPane.showMessageDialog(this, "Launch Vehicle not found.");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        JOptionPane.showMessageDialog(this, "Error updating launch vehicle.");
    }
}


    
    private void deleteLaunchVehicle() {
    int confirm = JOptionPane.showConfirmDialog(this, "Are you sure you want to delete this launch vehicle?", "Delete Launch Vehicle", JOptionPane.YES_NO_OPTION);
    if (confirm == JOptionPane.YES_OPTION) {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "DELETE FROM LaunchVehicle WHERE VehicleID = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, txtVehicleID.getText());

            int deletedRows = pst.executeUpdate();
            if (deletedRows > 0) {
                JOptionPane.showMessageDialog(this, "Launch Vehicle deleted successfully.");
                // Clear input fields after deletion
                txtVehicleID.setText("");
                txtVehicleName.setText("");
                txtVehicleType.setText("");
                txtPayloadCapacity.setText("");
                txtManufacturer.setText("");
                txtMissionID.setText("");
            } else {
                JOptionPane.showMessageDialog(this, "Launch Vehicle not found.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error deleting launch vehicle.");
        }
    }
}


    public static void main(String[] args) {
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            e.printStackTrace();
        }
        SwingUtilities.invokeLater(() -> new LaunchVehicleCRUD().setVisible(true));
    }
}
