library(tidyverse)

# 1. Az önkormányzati rendeletből kinyert strukturált övezeti adatok
# (Beépítési % felett, zöldfelület %, maximális magasság)
hesz_adatok <- tibble(
  Ovezet = c("Ln-1/Z-1 (Nagyvárosias)", "Ln-2/AI/SZ-1 (Nagyvárosias)", "Ln-2/SZ-1 (Nagyvárosias)", 
             "Lk-1/AI/Z-1 (Kisvárosias)", "Lk-1/SZ-1 (Kisvárosias)", 
             "Lk-2/AI/SZ-1 (Kisvárosias)", "Lke-2/AI/SZ-1 (Kertvárosias)", "Lke-2/SZ-1 (Kertvárosias)"),
  Kategoria = c("Nagyvárosias (Ln)", "Nagyvárosias (Ln)", "Nagyvárosias (Ln)",
                "Kisvárosias (Lk)", "Kisvárosias (Lk)", "Kisvárosias (Lk)", 
                "Kertvárosias (Lke)", "Kertvárosias (Lke)"),
  Max_Beepites = c(15, 25, 20, 2, 20, 25, 10, 25), # % felett
  Min_Zoldfelulet = c(75, 35, 30, 60, 75, 40, 75, 50), # %
  Max_Magassag = c(5.0, 9.5, 9.5, 4.5, 10.5, 9.5, 7.5, 7.5) # méter
)

# 2. Gyönyörű, kétdimenziós szabályozási mátrix grafikon
# Megmutatja, melyik övezetben mekkora a "beépítési mozgástér" (zöldfelület vs beépíthetőség)
p_hesz <- ggplot(hesz_adatok, aes(x = Max_Beepites, y = Min_Zoldfelulet, color = Kategoria, size = Max_Magassag)) +
  geom_point(alpha = 0.8) +
  scale_size_continuous(range = c(4, 12), name = "Max. magasság (m)") +
  scale_color_brewer(palette = "Set1", name = "Területhasználat") +
  geom_text(aes(label = Ovezet), color = "black", size = 3, vjust = -1.8, fontface = "bold", check_overlap = TRUE) +
  xlim(0, 40) +
  ylim(20, 90) +
  theme_minimal() +
  labs(
    title = "Helyi Építési Szabályzat (HÉSZ) Paraméterek Összehasonlítása",
    subtitle = "Beépíthetőség, kötelező zöldfelület és megengedett magasság övezetenként",
    x = "Maximális beépíthetőség terepszint felett (%)",
    y = "Minimális kötelező zöldfelület (%)"
  ) +
  theme(
    text = element_text(size = 11, color = "black"),
    plot.title = element_text(face = "bold", size = 13, color = "black"),
    plot.subtitle = element_text(color = "dimgray", size = 10),
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    panel.grid.major = element_line(color = "grey93"),
    panel.grid.minor = element_blank(),
    legend.position = "right"
  )

# Megjelenítés
print(p_hesz)

# 3. Mentés képként a projekt mappádba
ggsave(
  filename = "C:/Users/TokodiZoli/Documents/Documents/R projectek/ProphetR/hesz_ovezeti_elemzes.png",
  plot = p_hesz,
  width = 9,
  height = 6,
  dpi = 300,
  bg = "white"
)
