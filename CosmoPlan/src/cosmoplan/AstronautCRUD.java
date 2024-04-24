/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cosmoplan;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class AstronautCRUD extends JFrame {
    // Database credentials and connection string
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=CosmoPlan;encrypt=true;trustServerCertificate=true;";
    private static final String USER = "SA";
    private static final String PASSWORD = "Docker@123";

    // UI Components for Astronaut
    private JTextField txtAstronautID, txtCallSign, txtFirstName, txtLastName, txtDateOfBirth, txtNationality, txtGender, txtSpecialty;
    private JButton btnCreate, btnRead, btnUpdate, btnDelete, btnBack;

    public AstronautCRUD() {
        // Initialize UI Components
        createUI();

        // Set JFrame properties
        setTitle("Astronaut Management");
        setSize(500, 400);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    }

    private void createUI() {
        setLayout(new GridLayout(11, 2, 5, 5));

        txtAstronautID = new JTextField();
        txtCallSign = new JTextField();
        txtFirstName = new JTextField();
        txtLastName = new JTextField();
        txtDateOfBirth = new JTextField();
        txtNationality = new JTextField();
        txtGender = new JTextField();
        txtSpecialty = new JTextField();

        btnCreate = new JButton("Create");
        btnRead = new JButton("Read");
        btnUpdate = new JButton("Update");
        btnDelete = new JButton("Delete");
        JButton btnClear = new JButton("Clear");
        btnBack = new JButton("Back");

        add(new JLabel("Astronaut ID"));
        add(txtAstronautID);
        add(new JLabel("Call Sign"));
        add(txtCallSign);
        add(new JLabel("First Name"));
        add(txtFirstName);
        add(new JLabel("Last Name"));
        add(txtLastName);
        add(new JLabel("Date of Birth (YYYY-MM-DD)"));
        add(txtDateOfBirth);
        add(new JLabel("Nationality"));
        add(txtNationality);
        add(new JLabel("Gender (M/F/O)"));
        add(txtGender);
        add(new JLabel("Specialty"));
        add(txtSpecialty);

        add(btnCreate);
        add(btnRead);
        add(btnUpdate);
        add(btnDelete);
        add(btnClear);
        add(btnBack);

        // Event Handling
        btnBack.addActionListener(e -> backToDashboard());
        btnClear.addActionListener(e -> clearFields());
        btnCreate.addActionListener(e -> createAstronaut());
        btnRead.addActionListener(e -> readAstronaut());
        btnUpdate.addActionListener(e -> updateAstronaut());
        btnDelete.addActionListener(e -> deleteAstronaut());
    }
    private void clearFields() {
    txtAstronautID.setText("");
    txtCallSign.setText("");
    txtFirstName.setText("");
    txtLastName.setText("");
    txtDateOfBirth.setText("");
    txtNationality.setText("");
    txtGender.setText("");
    txtSpecialty.setText("");
    }
    private void backToDashboard() {
        Dashboard dashboard = new Dashboard(); // Create an instance of the Dashboard
        dashboard.setVisible(true); // Show the Dashboard window
        dispose(); // Close the current window (AgencyCRUD)
    }

    private void createAstronaut() {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "INSERT INTO Astronaut (AstronautID, CallSign, FirstName, LastName, DateOfBirth, Nationality, Gender, Specialty) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(txtAstronautID.getText()));
            pst.setString(2, txtCallSign.getText());
            pst.setString(3, txtFirstName.getText());
            pst.setString(4, txtLastName.getText());
            pst.setDate(5, Date.valueOf(txtDateOfBirth.getText()));
            pst.setString(6, txtNationality.getText());
            pst.setString(7, txtGender.getText().toUpperCase());
            pst.setString(8, txtSpecialty.getText());

            pst.executeUpdate();
            JOptionPane.showMessageDialog(this, "Astronaut created successfully.");
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error creating astronaut.");
        }
    }
    private void readAstronaut() {
    try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
        String sql = "SELECT * FROM Astronaut WHERE AstronautID = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setInt(1, Integer.parseInt(txtAstronautID.getText()));

        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            txtCallSign.setText(rs.getString("CallSign"));
            txtFirstName.setText(rs.getString("FirstName"));
            txtLastName.setText(rs.getString("LastName"));
            txtDateOfBirth.setText(rs.getDate("DateOfBirth").toString());
            txtNationality.setText(rs.getString("Nationality"));
            txtGender.setText(rs.getString("Gender"));
            txtSpecialty.setText(rs.getString("Specialty"));
        } else {
            JOptionPane.showMessageDialog(this, "Astronaut not found.");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        JOptionPane.showMessageDialog(this, "Error reading astronaut details.");
    }
}
private void updateAstronaut() {
    try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
        String sql = "UPDATE Astronaut SET CallSign = ?, FirstName = ?, LastName = ?, DateOfBirth = ?, Nationality = ?, Gender = ?, Specialty = ? WHERE AstronautID = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, txtCallSign.getText());
        pst.setString(2, txtFirstName.getText());
        pst.setString(3, txtLastName.getText());
        pst.setDate(4, Date.valueOf(txtDateOfBirth.getText()));
        pst.setString(5, txtNationality.getText());
        pst.setString(6, txtGender.getText().toUpperCase());
        pst.setString(7, txtSpecialty.getText());
        pst.setInt(8, Integer.parseInt(txtAstronautID.getText()));

        int updatedRows = pst.executeUpdate();
        if (updatedRows > 0) {
            JOptionPane.showMessageDialog(this, "Astronaut updated successfully.");
        } else {
            JOptionPane.showMessageDialog(this, "Astronaut not found.");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        JOptionPane.showMessageDialog(this, "Error updating astronaut.");
    }
}
private void deleteAstronaut() {
    int confirm = JOptionPane.showConfirmDialog(this, "Are you sure you want to delete this astronaut?", "Delete Astronaut", JOptionPane.YES_NO_OPTION);
    if (confirm == JOptionPane.YES_OPTION) {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "DELETE FROM Astronaut WHERE AstronautID = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(txtAstronautID.getText()));

            int deletedRows = pst.executeUpdate();
            if (deletedRows > 0) {
                JOptionPane.showMessageDialog(this, "Astronaut deleted successfully.");
                // Clear input fields after deletion
                txtAstronautID.setText("");
                txtCallSign.setText("");
                txtFirstName.setText("");
                txtLastName.setText("");
                txtDateOfBirth.setText("");
                txtNationality.setText("");
                txtGender.setText("");
                txtSpecialty.setText("");
            } else {
                JOptionPane.showMessageDialog(this, "Astronaut not found.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error deleting astronaut.");
        }
    }
}


 

    public static void main(String[] args) {
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            e.printStackTrace();
        }

        SwingUtilities.invokeLater(() -> new AstronautCRUD().setVisible(true));
    }
}
