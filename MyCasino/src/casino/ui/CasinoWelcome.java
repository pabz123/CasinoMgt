package casino.ui;

import javax.swing.*;
import java.awt.*;

public class CasinoWelcome extends JFrame {
    public CasinoWelcome() {
        setTitle("Welcome to Casino Management System");
        setSize(600, 500);
        
        setLocationRelativeTo(null);

        JPanel bgPanel = new JPanel() {
            private final Image bgImage = new ImageIcon(getClass().getResource("/resources/casino_bg.png")).getImage();

            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                g.drawImage(bgImage, 0, 0, getWidth(), getHeight(), this);
            }
        };
        bgPanel.setLayout(new BorderLayout());

        JButton btnEnter = new JButton("Enter Casino");
        btnEnter.setBackground(new Color(34, 139, 34));
        btnEnter.setForeground(Color.WHITE);
        btnEnter.setFocusPainted(false);
        btnEnter.setFont(new Font("Arial", Font.BOLD, 18));
        btnEnter.addActionListener(e -> {
            new CasinoLogin().setVisible(true);
            dispose();
        });

        bgPanel.add(btnEnter, BorderLayout.SOUTH);
        add(bgPanel);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new CasinoWelcome().setVisible(true));
    }
}
