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
