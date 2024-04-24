package cosmoplan;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class PayloadCRUD extends JFrame {
    // Database credentials and connection string
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=CosmoPlan;encrypt=true;trustServerCertificate=true;";
    private static final String USER = "SA";
    private static final String PASSWORD = "Docker@123";

    // UI Components
    private JTextField txtPayloadID, txtPayloadName, txtPayloadType, txtWeight;
    private JButton btnCreate, btnRead, btnUpdate, btnDelete, btnBack;

    public PayloadCRUD() {
        // Initialize UI Components
        createUI();

        // Set JFrame properties
        setTitle("Payload Management");
        setSize(500, 250);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    }

    private void createUI() {
        setLayout(new GridLayout(7, 2, 5, 5));

        txtPayloadID = new JTextField();
        txtPayloadName = new JTextField();
        txtPayloadType = new JTextField();
        txtWeight = new JTextField();

        btnCreate = new JButton("Create");
        btnRead = new JButton("Read");
        btnUpdate = new JButton("Update");
        btnDelete = new JButton("Delete");
        JButton btnClear = new JButton("Clear");
        btnBack = new JButton("Back");

        add(new JLabel("Payload ID"));
        add(txtPayloadID);
        add(new JLabel("Payload Name"));
        add(txtPayloadName);
        add(new JLabel("Payload Type"));
        add(txtPayloadType);
        add(new JLabel("Weight"));
        add(txtWeight);

        add(btnCreate);
        add(btnRead);
        add(btnUpdate);
        add(btnDelete);
        add(btnClear);
        add(btnBack);

        // Event Handling
        btnBack.addActionListener(e -> backToDashboard());
        btnClear.addActionListener(e -> clearFields());
        btnCreate.addActionListener(e -> createPayload());
        btnRead.addActionListener(e -> readPayload());
        btnUpdate.addActionListener(e -> updatePayload());
        btnDelete.addActionListener(e -> deletePayload());
    }
    private void clearFields() {
    txtPayloadID.setText("");
    txtPayloadName.setText("");
    txtPayloadType.setText("");
    txtWeight.setText("");
    }
    private void backToDashboard() {
        Dashboard dashboard = new Dashboard(); // Create an instance of the Dashboard
        dashboard.setVisible(true); // Show the Dashboard window
        dispose(); // Close the current window (AgencyCRUD)
    }

    private void createPayload() {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "INSERT INTO Payload (PayloadID, PayloadName, PayloadType, Weight) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(txtPayloadID.getText()));
            pst.setString(2, txtPayloadName.getText());
            pst.setString(3, txtPayloadType.getText());
            pst.setDouble(4, Double.parseDouble(txtWeight.getText()));

            pst.executeUpdate();
            JOptionPane.showMessageDialog(this, "Payload created successfully.");
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error creating payload.");
        }
    }

    private void readPayload() {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "SELECT * FROM Payload WHERE PayloadID = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(txtPayloadID.getText()));

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                txtPayloadName.setText(rs.getString("PayloadName"));
                txtPayloadType.setText(rs.getString("PayloadType"));
                txtWeight.setText(rs.getString("Weight"));
            } else {
                JOptionPane.showMessageDialog(this, "Payload not found.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error reading payload details.");
        }
    }

    private void updatePayload() {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "UPDATE Payload SET PayloadName = ?, PayloadType = ?, Weight = ? WHERE PayloadID = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, txtPayloadName.getText());
            pst.setString(2, txtPayloadType.getText());
            pst.setDouble(3, Double.parseDouble(txtWeight.getText()));
            pst.setInt(4, Integer.parseInt(txtPayloadID.getText()));

            int updatedRows = pst.executeUpdate();
            if (updatedRows > 0) {
                JOptionPane.showMessageDialog(this, "Payload updated successfully.");
            } else {
                JOptionPane.showMessageDialog(this, "Payload not found.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error updating payload.");
        }
    }

    private void deletePayload() {
        int confirm = JOptionPane.showConfirmDialog(this, "Are you sure you want to delete this payload?", "Delete Payload", JOptionPane.YES_NO_OPTION);
        if (confirm == JOptionPane.YES_OPTION) {
            try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
                String sql = "DELETE FROM Payload WHERE PayloadID = ?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setInt(1, Integer.parseInt(txtPayloadID.getText()));

                int deletedRows = pst.executeUpdate();
                if (deletedRows > 0) {
                    JOptionPane.showMessageDialog(this, "Payload deleted successfully.");
                    // Clear input fields after deletion
                    txtPayloadID.setText("");
                    txtPayloadName.setText("");
                    txtPayloadType.setText("");
                    txtWeight.setText("");
                } else {
                    JOptionPane.showMessageDialog(this, "Payload not found.");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(this, "Error deleting payload.");
            }
        }
    }

    public static void main(String[] args) {
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            e.printStackTrace();
        }

        SwingUtilities.invokeLater(() -> new PayloadCRUD().setVisible(true));
    }
}

