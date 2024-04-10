package cosmoplan;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Dashboard extends JFrame {
    private JPanel contentPane;

    public Dashboard() {
        setTitle("CosmoPlan Dashboard");
        setSize(800, 600); // Adjusted for additional buttons
        setLocationRelativeTo(null); // Center the window
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        
        // Set up the content pane with a background image
        contentPane = new JPanel() {
            public void paintComponent(Graphics g) {
                super.paintComponent(g);
                ImageIcon img = new ImageIcon("/Users/dhwanilpanchani/NetBeansProjects/CosmoPlan/earth.jpeg");
                g.drawImage(img.getImage(), 0, 0, this.getWidth(), this.getHeight(), null);
            }
        };
        setContentPane(contentPane);
        contentPane.setLayout(new FlowLayout(FlowLayout.CENTER, 20, 20));

        // Adjust the layout to better accommodate the buttons
        contentPane.setLayout(new GridLayout(0, 1, 10, 10)); // Single column layout

        // Create and add buttons for each CRUD operation
        addCrudButton("Manage Missions", MissionCRUD.class);
        addCrudButton("Manage Agencies", AgencyCRUD.class);
        addCrudButton("Manage Astronauts", AstronautCRUD.class);
        addCrudButton("Manage Spacecraft", SpacecraftCRUD.class);
        addCrudButton("Manage Launch Vehicles", LaunchVehicleCRUD.class);
        addCrudButton("Manage Launch Sites", LaunchSiteCRUD.class);
        addCrudButton("Manage Payloads", PayloadCRUD.class);

        // Customize the global look and feel
        getContentPane().setBackground(Color.WHITE); // Light background
    }

    private void addCrudButton(String title, Class<? extends JFrame> crudClass) {
        JButton button = new JButton(title);
        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                EventQueue.invokeLater(() -> {
                    try {
                        JFrame frame = crudClass.newInstance();
                        frame.setVisible(true);
                    } catch (InstantiationException | IllegalAccessException ex) {
                        ex.printStackTrace();
                    }
                });
            }
        });
        styleButton(button);
        contentPane.add(button);
    }

    // Utility method to style buttons
//    private void styleButton(JButton button) {
//        button.setFont(new Font("Arial", Font.BOLD, 14));
//        button.setBackground(new Color(173, 216, 230)); // Light blue background
//        button.setForeground(Color.DARK_GRAY);
//        button.setFocusPainted(false);
//        button.setBorderPainted(false);
//    }
    // Utility method to style buttons
    private void styleButton(JButton button) {
    button.setFont(new Font("Arial", Font.BOLD, 14));
    button.setBackground(new Color(173, 216, 230)); // Light blue background
    button.setForeground(Color.WHITE); // Set font color to white
    button.setFocusPainted(false);
    button.setBorderPainted(false);
    }


    public static void main(String[] args) {
        EventQueue.invokeLater(() -> {
            try {
                UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
            } catch (Exception e) {
                e.printStackTrace();
            }
            new Dashboard().setVisible(true);
        });
    }
}




