# An Effective Greedy Heuristic for the Social Golfer Problem  #

The Social Golfer Problem (SGP) is a combinatorial optimization problem that involves scheduling `n` golfers into `g` groups of `p` players for `w` weeks such that no two players are in the same group more than once. This problem is highly symmetrical and complex, making it an interesting challenge for constraint solvers and metaheuristic approaches.

## Solutions Presented
1. **Greedy Heuristic for Backtracking**
   - Uses the concept of "freedom" among players, where freedom indicates how many other players a golfer can still partner with.
   - Prioritizes pairing golfers with the least freedom to ensure they get scheduled while it's still possible.
   - When a group cannot be completed, backtracking occurs to select a different pair of players with slightly higher freedom.

2. **Randomized Greedy Initial Configurations for Local Search**
   - Creates initial configurations by maximizing the freedom of pairs of players and introducing slight random perturbations.
   - Adjusts freedom dynamically to discourage reusing the same pairs.
   - Balances randomness and deterministic selection to optimize initial groupings.

3. **Local Search Component**
   - Simplifies existing local search methods by removing the restart component and fixing the length of tabu lists to 10.
   - Focuses on reducing conflicts, where a conflict occurs if two players are grouped together more than once.
   - Implements tabu lists to store recent exchanges and makes random swaps if no improvement is observed for several iterations.

## Experimental Results
- The approach solved many SGP instances, including the original 8-4-10 instance, which had been unsolved by previous methods.
- The greedy heuristic significantly improved the effectiveness of local search, making it competitive with other state-of-the-art methods.

## Insights
1. SGP involves complex symmetry and constraints, making traditional methods challenging.
2. The greedy heuristic uses "freedom" to prioritize scheduling, effectively reducing conflicts.
3. Combining greedy heuristics with local search improves overall problem-solving efficiency.

## The Essence (80/20)
- **Core Topic:** SGP involves scheduling golfers to ensure no repeat pairings within groups across weeks.
- **Detailed Description:** The paper introduces a greedy heuristic based on the concept of "freedom" among players, using it to guide both a complete backtracking search and to generate effective initial configurations for local search. This method successfully matches or surpasses the results of more complex constraint solvers and metaheuristic approaches.

## Plan
1. **Implement the Greedy Heuristic**
   - Calculate and use the freedom of players to prioritize pairings.
   - Apply this heuristic in a backtracking algorithm to handle scheduling conflicts.

2. **Generate Initial Configurations**
   - Use the greedy heuristic to create initial player groupings.
   - Introduce slight random perturbations to diversify the starting point for local search.

3. **Optimize Local Search**
   - Focus on minimizing conflicts through strategic swaps.
   - Use tabu lists to prevent cycling back to previous configurations.
   - Make random swaps if no progress is observed after several iterations.

# A greedy algorithm for the social golfer and the Oberwolfach problem #

The **Social Golfer Problem (SGP)** involves scheduling golfers into groups such that no two golfers play together more than once. Specifically, it generalizes to scheduling `n` golfers into `g` groups of `p` players each for `w` weeks while ensuring that no two golfers share a group more than once.

## Solutions Presented
1. **Greedy Algorithm for SGP**
   - The algorithm focuses on a greedy approach to iteratively remove cliques (groups) of size `k` from the complete graph of players.
   - It guarantees a minimum number of rounds that can be scheduled without preplanning.

2. **Mathematical Guarantees**
   - For any tournament with `n` players and match sizes of `k`, the greedy algorithm can always guarantee `⌊n / (k(k-1))⌋` rounds.
   - This bound is proven to be tight, meaning it's the best possible guarantee for the greedy algorithm.

3. **Extensions and Applications**
   - The greedy algorithm is applied to the Oberwolfach problem, which involves seating assignments at round tables ensuring no two participants sit next to each other more than once.
   - The approach can be adapted for different sports and tournament formats, providing a polynomial time approximation algorithm for the SGP.

## Insights
1. The SGP ensures no repeat pairings in scheduled groups.
2. The greedy algorithm effectively manages groupings by iteratively removing cliques.
3. Mathematical proofs validate the algorithm's effectiveness and bounds.

### The Essence (80/20)
- **Core Topic:** SGP requires scheduling groups without repeat pairings.
- **Detailed Description:** The greedy algorithm schedules rounds by iteratively removing cliques of players from a complete graph, guaranteeing a specific minimum number of rounds. This method provides a simple yet effective solution for the SGP and related problems like the Oberwolfach problem.

## Plan
1. **Implement Greedy Algorithm**
   - Apply the algorithm to iteratively remove cliques from the player graph.
   - Ensure to follow the mathematical guarantees for the number of rounds.

2. **Adapt for Specific Sports**
   - Customize the algorithm based on the sport's requirements (e.g., different group sizes or constraints).
   - Use the polynomial time approximation for practical scheduling.

3. **Validate Results**
   - Test the algorithm on various tournament instances to ensure it meets the guaranteed bounds.
   - Adjust parameters as necessary to optimize scheduling for specific conditions.
