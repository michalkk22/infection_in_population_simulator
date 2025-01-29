# infection_in_population_simulator

A Flutter project for my studies

App simulates a population with a number of intected individuals at the start. They keep moving at random speed and directions within an area. Upon hitting border there's chance to bounce back in or vanish. New individuals spawn at borders periodically, they have chance to be infected. Infected become immune after a while. For infection to spread, an infected individual must remain in certain range to a susceptible individual for a period of time. After this condidion is fulfilled, if the infected has symptoms the susceptible allways become infected, if the infected has no symptoms theres a checne to infect.

All the percantage chances, time intervals, move speed etc. are set as constatns in simulation_config.dart
