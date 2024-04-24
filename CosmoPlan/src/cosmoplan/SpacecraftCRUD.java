package cosmoplan;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class SpacecraftCRUD extends JFrame {
    // Database credentials and connection string
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=CosmoPlan;encrypt=true;trustServerCertificate=true;";
    private static final String USER = "SA";
    private static final String PASSWORD = "Docker@123";

    // UI Components for Spacecraft
    private JTextField txtCraftID, txtCraftName, txtSpacecraftType, txtPayloadCapacity, txtSpacecraftStatus, txtMissionID;
    private JButton btnCreate, btnRead, btnUpdate, btnDelete, btnBack;

    public SpacecraftCRUD() {
        // Initialize UI Components
        createUI();

        // Set JFrame properties
        setTitle("Spacecraft Management");
        setSize(500, 400);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    }

    private void createUI() {
        setLayout(new GridLayout(9, 2, 5, 5));

        txtCraftID = new JTextField();
        txtCraftName = new JTextField();
        txtSpacecraftType = new JTextField();
        txtPayloadCapacity = new JTextField();
        txtSpacecraftStatus = new JTextField();
        txtMissionID = new JTextField();

        btnCreate = new JButton("Create");
        btnRead = new JButton("Read");
        btnUpdate = new JButton("Update");
        btnDelete = new JButton("Delete");
        JButton btnClear = new JButton("Clear");
        btnBack = new JButton("Back");

        add(new JLabel("Craft ID"));
        add(txtCraftID);
        add(new JLabel("Craft Name"));
        add(txtCraftName);
        add(new JLabel("Spacecraft Type"));
        add(txtSpacecraftType);
        add(new JLabel("Payload Capacity"));
        add(txtPayloadCapacity);
        add(new JLabel("Spacecraft Status"));
        add(txtSpacecraftStatus);
        add(new JLabel("Mission ID (Optional)"));
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
        btnCreate.addActionListener(e -> createSpacecraft());
        btnRead.addActionListener(e -> readSpacecraft());
        btnUpdate.addActionListener(e -> updateSpacecraft());
        btnDelete.addActionListener(e -> deleteSpacecraft());
    }
    private void clearFields() {
    txtCraftID.setText("");
    txtCraftName.setText("");
    txtSpacecraftType.setText("");
    txtPayloadCapacity.setText("");
    txtSpacecraftStatus.setText("");
    txtMissionID.setText("");
    }
    private void backToDashboard() {
        Dashboard dashboard = new Dashboard(); // Create an instance of the Dashboard
        dashboard.setVisible(true); // Show the Dashboard window
        dispose(); // Close the current window (AgencyCRUD)
    }

    private void createSpacecraft() {
    try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
        String sql = "INSERT INTO Spacecraft (CraftID, CraftName, SpacecraftType, PayloadCapacity, SpacecraftStatus, MissionID) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, txtCraftID.getText());
        pst.setString(2, txtCraftName.getText());
        pst.setString(3, txtSpacecraftType.getText());
        pst.setDouble(4, Double.parseDouble(txtPayloadCapacity.getText()));
        pst.setString(5, txtSpacecraftStatus.getText());
        pst.setString(6, txtMissionID.getText().isEmpty() ? null : txtMissionID.getText()); // Assuming MissionID is optional

        pst.executeUpdate();
        JOptionPane.showMessageDialog(this, "Spacecraft created successfully.");
    } catch (Exception ex) {
        ex.printStackTrace();
        JOptionPane.showMessageDialog(this, "Error creating spacecraft.");
    }
}


   
    private void readSpacecraft() {
    try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
        String sql = "SELECT * FROM Spacecraft WHERE CraftID = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, txtCraftID.getText());

        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            txtCraftName.setText(rs.getString("CraftName"));
            txtSpacecraftType.setText(rs.getString("SpacecraftType"));
            txtPayloadCapacity.setText(String.valueOf(rs.getDouble("PayloadCapacity")));
            txtSpacecraftStatus.setText(rs.getString("SpacecraftStatus"));
            txtMissionID.setText(rs.getString("MissionID"));
        } else {
            JOptionPane.showMessageDialog(this, "Spacecraft not found.");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        JOptionPane.showMessageDialog(this, "Error reading spacecraft details.");
    }
}


 
    private void updateSpacecraft() {
    try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
        String sql = "UPDATE Spacecraft SET CraftName = ?, SpacecraftType = ?, PayloadCapacity = ?, SpacecraftStatus = ?, MissionID = ? WHERE CraftID = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, txtCraftName.getText());
        pst.setString(2, txtSpacecraftType.getText());
        pst.setDouble(3, Double.parseDouble(txtPayloadCapacity.getText()));
        pst.setString(4, txtSpacecraftStatus.getText());
        // Handling optional MissionID: set to NULL if the field is empty
        if(txtMissionID.getText().isEmpty()) {
            pst.setNull(5, Types.VARCHAR);
        } else {
            pst.setString(5, txtMissionID.getText());
        }
        pst.setString(6, txtCraftID.getText());

        int updatedRows = pst.executeUpdate();
        if (updatedRows > 0) {
            JOptionPane.showMessageDialog(this, "Spacecraft updated successfully.");
        } else {
            JOptionPane.showMessageDialog(this, "Spacecraft not found.");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        JOptionPane.showMessageDialog(this, "Error updating spacecraft.");
    }
}


    private void deleteSpacecraft() {
    int confirm = JOptionPane.showConfirmDialog(this, "Are you sure you want to delete this spacecraft?", "Delete Spacecraft", JOptionPane.YES_NO_OPTION);
    if (confirm == JOptionPane.YES_OPTION) {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "DELETE FROM Spacecraft WHERE CraftID = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, txtCraftID.getText());

            int deletedRows = pst.executeUpdate();
            if (deletedRows > 0) {
                JOptionPane.showMessageDialog(this, "Spacecraft deleted successfully.");
                // Clear input fields after deletion
                txtCraftID.setText("");
                txtCraftName.setText("");
                txtSpacecraftType.setText("");
                txtPayloadCapacity.setText("");
                txtSpacecraftStatus.setText("");
                txtMissionID.setText("");
            } else {
                JOptionPane.showMessageDialog(this, "Spacecraft not found.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error deleting spacecraft.");
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

        SwingUtilities.invokeLater(() -> new SpacecraftCRUD().setVisible(true));
    }
}
