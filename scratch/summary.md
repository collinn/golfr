# Project Overview: Coming up with "good-enough" near-solution for the Social Golfer Problem in R #

1) Objectives 
- Arrange students into groups across multiple rounds in a way of minimizing the occasions in which two or more students are grouped together more than once
- Calculate conflict score to estimate how many overlaps happen (minimizing is the goal)

2) Challenges
- The problem grows exponentially in complexity with more players, groups, or rounds.
- How to deal with the situations where there are odd number of players with even number of groups?
- In the progress of calculating conflict score, the weight matrix of the current round ("weight matrix") and the sum of all the weight matrices before the current round ("cumulative matrix") are necessary. To save the program from heavy computation, is there any way to "save" the cumulative matrix and add each round's weight matrix to update it?
- How to decide on the initial grouping? (Does the initial grouping affect the conflict score of the groupings afterwards?)
- How to decide on the second, third, ... , nth groupings in a way to minimize the conflict score?
  - Two ways: one is to start at the initial point and choose one with the lowest conflict score from random 10 neighbors ("candidates") each round. Initial point does not change, and repeat choosing 10 random candidates to select one with the lowest conflict score. The other is to start at the initial point, choose one with the lowest conflict score from 10 candidates, and set the chosen candidate as the new initial point, and choose the candidates again based on the new initial point.

3) Approach: Adapt an existing JavaScript solution (using a genetic algorithm) to develop an R-based solution focused on:
  - Generating initial and subsequent candidate groupings.
  - Calculating conflict scores for each candidate configuration.

# Solution Components in R #

1) Generating Initial Group Permutations
  - Function: `generatePermutation`
  - Purpose: Creates initial random group assignments for players.
  - Process: 
    - Calculates the total number of players (`totalSize`), shuffles player indices, and divides them into groups.
    - Generates 10 candidate group configurations, used to explore different options in subsequent rounds.


2) Creating Weight Matrices for Conflict Tracking
  - Purpose: Track pairwise conflicts across rounds to penalize repeated groupings.
  - Functions:
    - `roundmat`: Generates an initial weight matrix for each round from the provided group data.
    - `GenerateMutation`: Uses the candidate group assignments from `generatePermutation` to create weight matrices for each candidate configuration.
    
3) Calculating Conflict Scores
- Function: `Final`
  - Purpose: Calculate conflict scores to evaluate each candidate.
  - Method:
    - Calculates the conflict score by taking a cumulative matrix and assessing conflicts that arise when players are repeatedly grouped together.
    - The score is the sum of squared conflict weights from cumulative pair conflicts.
- Function: `Conflict`
  - Purpose: Use cumulative matrices across rounds to avoid recalculating scores from scratch each round.
  - How It Works:
    - Updates the cumulative matrix for each candidate in the current round.
    - Calls `Final` to compute conflict scores for each candidate.

4) Incrementally Updating Cumulative Matrices
- Objective: Improve efficiency by incrementally updating cumulative matrices rather than recalculating them for each round.
- Implementation: 
  - Cumulative matrices from previous rounds are stored and updated each round by adding the best candidate’s weight matrix.
  - Benefit: Prevents repeated calculations, making the process more scalable and efficient.
- Usage in Workflow:
  - The cumulative matrix approach allows efficient conflict tracking across rounds, with each new candidate only updating the previous cumulative matrix.