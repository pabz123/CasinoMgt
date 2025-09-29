package casino.ui;


import casino.db.DBConnection;
import javax.swing.*;
import java.awt.*;
import java.sql.*;
import java.util.HashSet;
import java.util.Set;

public class CasinoSignup extends JFrame {
    private final JTextField txtUsername;
    private final JPasswordField txtPassword;
    private final JTextField txtEmail;
    private final JComboBox<String> cmbRole;

    public CasinoSignup() {
        setTitle("Casino Signup");
        setSize(600, 500);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);
        
        JPanel bgPanel = new JPanel() {
            private final Image bgImage = new ImageIcon(getClass().getResource("/resources/casino_bg.png")).getImage();
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                g.drawImage(bgImage, 0, 0, getWidth(), getHeight(), this);
            }
        };
        bgPanel.setLayout(new GridBagLayout());

        JPanel panel = new JPanel();
        panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
        
        
        panel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        panel.setPreferredSize(new Dimension(320, 200));
        panel.setBackground(new Color(0, 0, 0, 150));
        
        JLabel lblUser = new JLabel(" Username:");
        lblUser.setForeground(Color.WHITE);
        txtUsername = new JTextField(10);
        JLabel lblEmail = new JLabel("E-mail:");
        lblEmail.setForeground(Color.WHITE);
        txtEmail = new JTextField(10);
        

        JLabel lblPass = new JLabel(" Password:");
        lblPass.setForeground(Color.WHITE);
        txtPassword = new JPasswordField(10);

        JLabel lblRole = new JLabel("Select Role:");
        lblRole.setForeground(Color.WHITE);
        cmbRole = new JComboBox<>(new String[]{ "Cashier", "Security","Game Manager","Restuarant Manager"});

        JButton btnRegister = new JButton("Register");
        styleButton(btnRegister);
        btnRegister.addActionListener(e -> register());

        panel.add(lblUser);
        panel.add(txtUsername);
        panel.add(lblPass);
         panel.add(txtPassword);
        panel.add(lblEmail);
        panel.add(txtEmail);
       
        panel.add(lblRole);
        panel.add(cmbRole);
        panel.add(new JLabel());
        panel.add(btnRegister);

        bgPanel.add(panel);
        add(bgPanel);
    }
        private void styleButton(JButton button) {
        button.setBackground(new Color(34, 139, 34));
        button.setForeground(Color.WHITE);
        button.setFont(new Font("Arial", Font.BOLD, 14));
        button.setFocusPainted(false);

        button.addMouseListener(new java.awt.event.MouseAdapter() {
            @Override
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                button.setBackground(new Color(0, 100, 0));
            }
            @Override
            public void mouseExited(java.awt.event.MouseEvent evt) {
                button.setBackground(new Color(34, 139, 34));
            }
        });
    }
    private void register() {
        String username = txtUsername.getText();
        String email = txtEmail.getText();
        String password = new String(txtPassword.getPassword());
        String role = cmbRole.getSelectedItem().toString();

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO app_users (username,email, password_hash, employee_role) VALUES (?, ?, ?, ?)"
            );
            ps.setString(1, username);
            ps.setString(2, password);// ⚠️ later replace with BCrypt hash
            ps.setString(3, email);
            ps.setString(4, role);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                JOptionPane.showMessageDialog(this, "User registered successfully!");
                dispose();
            } else {
                JOptionPane.showMessageDialog(this, "Registration failed.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage());
        }
    }
}
