package cosmoplan;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class AgencyCRUD extends JFrame {
    // Database credentials and connection string
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=CosmoPlan;encrypt=true;trustServerCertificate=true;";
    private static final String USER = "SA";
    private static final String PASSWORD = "Docker@123";

    // UI Components for Agency
    private JTextField txtAgencyID, txtAgencyName, txtCountry, txtDirector, txtAgencyBudget;
    private JButton btnCreate, btnRead, btnUpdate, btnDelete, btnBack;

    public AgencyCRUD() {
        createUI();
        setTitle("Agency Management");
        setSize(500, 300);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    }

    private void createUI() {
        setLayout(new GridLayout(9, 2, 5, 5));

        txtAgencyID = new JTextField();
        txtAgencyName = new JTextField();
        txtCountry = new JTextField();
        txtDirector = new JTextField();
        txtAgencyBudget = new JTextField();

        btnCreate = new JButton("Create");
        btnRead = new JButton("Read");
        btnUpdate = new JButton("Update");
        btnDelete = new JButton("Delete");
        JButton btnClear = new JButton("Clear");
        btnBack = new JButton("Back");

        add(new JLabel("Agency ID"));
        add(txtAgencyID);
        add(new JLabel("Agency Name"));
        add(txtAgencyName);
        add(new JLabel("Country"));
        add(txtCountry);
        add(new JLabel("Director"));
        add(txtDirector);
        add(new JLabel("Budget"));
        add(txtAgencyBudget);

        add(btnCreate);
        add(btnRead);
        add(btnUpdate);
        add(btnDelete);
        add(btnClear);
        add(btnBack);

        btnClear.addActionListener(e -> clearFields());
        btnBack.addActionListener(e -> backToDashboard());
        // Event Handling
        btnCreate.addActionListener(e -> createAgency());
        btnRead.addActionListener(e -> readAgency());
        btnUpdate.addActionListener(e -> updateAgency());
        btnDelete.addActionListener(e -> deleteAgency());
    }
    private void clearFields() {
    txtAgencyID.setText("");
    txtAgencyName.setText("");
    txtCountry.setText("");
    txtDirector.setText("");
    txtAgencyBudget.setText("");
    }
    private void backToDashboard() {
        Dashboard dashboard = new Dashboard(); // Create an instance of the Dashboard
        dashboard.setVisible(true); // Show the Dashboard window
        dispose(); // Close the current window (AgencyCRUD)
    }

    private void createAgency() {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "INSERT INTO Agency (AgencyID, AgencyName, Country, Director, AgencyBudget) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, txtAgencyID.getText());
            pst.setString(2, txtAgencyName.getText());
            pst.setString(3, txtCountry.getText());
            pst.setString(4, txtDirector.getText());
            pst.setDouble(5, Double.parseDouble(txtAgencyBudget.getText()));

            pst.executeUpdate();
            JOptionPane.showMessageDialog(this, "Agency created successfully.");
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error creating agency.");
        }
    }

    private void readAgency() {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "SELECT * FROM Agency WHERE AgencyID = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, txtAgencyID.getText());

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                txtAgencyName.setText(rs.getString("AgencyName"));
                txtCountry.setText(rs.getString("Country"));
                txtDirector.setText(rs.getString("Director"));
                txtAgencyBudget.setText(String.valueOf(rs.getDouble("AgencyBudget")));
            } else {
                JOptionPane.showMessageDialog(this, "Agency not found.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error reading agency details.");
        }
    }

    private void updateAgency() {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "UPDATE Agency SET AgencyName = ?, Country = ?, Director = ?, AgencyBudget = ? WHERE AgencyID = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, txtAgencyName.getText());
            pst.setString(2, txtCountry.getText());
            pst.setString(3, txtDirector.getText());
            pst.setDouble(4, Double.parseDouble(txtAgencyBudget.getText()));
            pst.setString(5, txtAgencyID.getText());

            int updatedRows = pst.executeUpdate();
            if (updatedRows > 0) {
                JOptionPane.showMessageDialog(this, "Agency updated successfully.");
            } else {
                JOptionPane.showMessageDialog(this, "Agency not found.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error updating agency.");
        }
    }

    private void deleteAgency() {
        int confirm = JOptionPane.showConfirmDialog(this, "Are you sure you want to delete this agency?", "Delete Agency", JOptionPane.YES_NO_OPTION);
        if (confirm == JOptionPane.YES_OPTION) {
            try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
                String sql = "DELETE FROM Agency WHERE AgencyID = ?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, txtAgencyID.getText());

                int deletedRows = pst.executeUpdate();
                if (deletedRows > 0) {
                    JOptionPane.showMessageDialog(this, "Agency deleted successfully.");
                    // Clear input fields after deletion
                    txtAgencyID.setText("");
                    txtAgencyName.setText("");
                    txtCountry.setText("");
                    txtDirector.setText("");
                    txtAgencyBudget.setText("");
                } else {
                    JOptionPane.showMessageDialog(this, "Agency not found.");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(this, "Error deleting agency.");
            }
        }
    }
    




    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new AgencyCRUD().setVisible(true));
    }
}

