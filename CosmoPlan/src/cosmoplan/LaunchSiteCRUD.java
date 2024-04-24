package cosmoplan;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class LaunchSiteCRUD extends JFrame {
    // Database credentials and connection string
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=CosmoPlan;encrypt=true;trustServerCertificate=true;";
    private static final String USER = "SA";
    private static final String PASSWORD = "Docker@123";

    // UI Components for LaunchSite
    private JTextField txtSiteID, txtSiteName, txtLocation, txtLaunchCapacity;
    private JButton btnCreate, btnRead, btnUpdate, btnDelete, btnBack;

    public LaunchSiteCRUD() {
        createUI();
        setTitle("LaunchSite Management");
        setSize(500, 300);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    }

    private void createUI() {
        setLayout(new GridLayout(7, 2, 5, 5));

        txtSiteID = new JTextField();
        txtSiteName = new JTextField();
        txtLocation = new JTextField();
        txtLaunchCapacity = new JTextField();

        btnCreate = new JButton("Create");
        btnRead = new JButton("Read");
        btnUpdate = new JButton("Update");
        btnDelete = new JButton("Delete");
        JButton btnClear = new JButton("Clear");
        btnBack = new JButton("Back");

        add(new JLabel("Site ID"));
        add(txtSiteID);
        add(new JLabel("Site Name"));
        add(txtSiteName);
        add(new JLabel("Location"));
        add(txtLocation);
        add(new JLabel("Launch Capacity"));
        add(txtLaunchCapacity);

        add(btnCreate);
        add(btnRead);
        add(btnUpdate);
        add(btnDelete);
        add(btnClear);
        add(btnBack);

        // Event Handling
        btnBack.addActionListener(e -> backToDashboard());
        btnClear.addActionListener(e -> clearFields());
        btnCreate.addActionListener(e -> createLaunchSite());
        btnRead.addActionListener(e -> readLaunchSite());
        btnUpdate.addActionListener(e -> updateLaunchSite());
        btnDelete.addActionListener(e -> deleteLaunchSite());
    }
    private void clearFields() {
    txtSiteID.setText("");
    txtSiteName.setText("");
    txtLocation.setText("");
    txtLaunchCapacity.setText("");
    }
    private void backToDashboard() {
        Dashboard dashboard = new Dashboard(); // Create an instance of the Dashboard
        dashboard.setVisible(true); // Show the Dashboard window
        dispose(); // Close the current window (AgencyCRUD)
    }

    private void createLaunchSite() {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "INSERT INTO LaunchSite (SiteID, SiteName, Location, LaunchCapacity) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(txtSiteID.getText()));
            pst.setString(2, txtSiteName.getText());
            pst.setString(3, txtLocation.getText());
            pst.setInt(4, Integer.parseInt(txtLaunchCapacity.getText()));

            pst.executeUpdate();
            JOptionPane.showMessageDialog(this, "LaunchSite created successfully.");
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error creating LaunchSite.");
        }
    }

    private void readLaunchSite() {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "SELECT * FROM LaunchSite WHERE SiteID = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(txtSiteID.getText()));

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                txtSiteName.setText(rs.getString("SiteName"));
                txtLocation.setText(rs.getString("Location"));
                txtLaunchCapacity.setText(String.valueOf(rs.getInt("LaunchCapacity")));
            } else {
                JOptionPane.showMessageDialog(this, "LaunchSite not found.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error reading LaunchSite details.");
        }
    }

    private void updateLaunchSite() {
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "UPDATE LaunchSite SET SiteName = ?, Location = ?, LaunchCapacity = ? WHERE SiteID = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, txtSiteName.getText());
            pst.setString(2, txtLocation.getText());
            pst.setInt(3, Integer.parseInt(txtLaunchCapacity.getText()));
            pst.setInt(4, Integer.parseInt(txtSiteID.getText()));

            int updatedRows = pst.executeUpdate();
            if (updatedRows > 0) {
                JOptionPane.showMessageDialog(this, "LaunchSite updated successfully.");
            } else {
                JOptionPane.showMessageDialog(this, "LaunchSite not found.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error updating LaunchSite.");
        }
    }

    private void deleteLaunchSite() {
        int confirm = JOptionPane.showConfirmDialog(this, "Are you sure you want to delete this LaunchSite?", "Delete LaunchSite", JOptionPane.YES_NO_OPTION);
        if (confirm == JOptionPane.YES_OPTION) {
            try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
                String sql = "DELETE FROM LaunchSite WHERE SiteID = ?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setInt(1, Integer.parseInt(txtSiteID.getText()));

                int deletedRows = pst.executeUpdate();
                if (deletedRows > 0) {
                    JOptionPane.showMessageDialog(this, "LaunchSite deleted successfully.");
                    // Clear input fields after deletion
                    txtSiteID.setText("");
                    txtSiteName.setText("");
                    txtLocation.setText("");
                    txtLaunchCapacity.setText("");
                } else {
                    JOptionPane.showMessageDialog(this, "LaunchSite not found.");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(this, "Error deleting LaunchSite.");
            }
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new LaunchSiteCRUD().setVisible(true));
    }
}
