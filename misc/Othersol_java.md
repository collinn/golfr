*const GENERATIONS = 30*
*const RANDOM_MUTATIONS = 2*
*const MAX_DESCENDANTS_TO_EXPLORE = 100**

These are constants defining the parameters for the genetic algorithm.
GENERATIONS sets the number of generations for the genetic algorithm,
RANDOM_MUTATIONS defines the number of random mutations to introduce in each generation,
and MAX_DESCENDANTS_TO_EXPLORE limits the number of descendant permutations to explore in each generation.

*function geneticSolver(*
  *groups, ofSize, forRounds, withGroupLeaders,*
  *forbiddenPairs=[], discouragedGroups=[], onProgress*
  *) {*
  *const totalSize = groups ofSize;*

This function is the main solver for the social golfer problem.
It takes the number of groups, the size of each group, the number of rounds,
a flag for group leaders, arrays for forbidden pairs and discouraged groups,
and a callback function for progress updates.
totalSize calculates the total number of players.

  *function score(round, weights) {*
    *const groupScores = round.map(group => {*
      *let groupCost = 0*
      *forEachPair(group, (a, b) => groupCost += Math.pow(weights[a][b], 2))*
      *return groupCost*
    *})*
    *return {*
      *groups: round,*
      *groupsScores: groupScores,*
      *total: groupScores.reduce((sum, next) => sum + next, 0),*
    *}*
  *}*

The score function calculates the cost of a given round configuration based on weights. 
It iterates through each group, computes the cost of each pair within the group
using the weights matrix, and returns an object containing the group configuration,
individual group scores, and the total score.

  *function generatePermutation() {*
    *const shuffleStart = withGroupLeaders ? groups : 0;*
    *const shuffledPeople = _.shuffle(_.range(shuffleStart, groups * ofSize));*
    *const shuffledPerGroup = shuffledPeople.length / groups;*
    *return _.range(groups).map(i => {*
      *const group = [];*
      *if (withGroupLeaders) {*
        *group.push(i);*
      *}*
      *group.push(...shuffledPeople.slice(i * shuffledPerGroup, (i+1) * shuffledPerGroup));*
      *return group;*
    *});*

  *}*

The generatePermutation function creates a shuffled configuration of players into groups.
If withGroupLeaders is set, the first groups players are assigned deterministically to each group.
The rest are shuffled and divided into groups.

  *function generateMutations(candidates, weights) {*
    *const mutations = []*
    *candidates.forEach(candidate => {*
      *const scoredGroups = candidate.groups.map((g, i) => ({group: g, score: candidate.groupsScores[i]}))*
      *const sortedScoredGroups = _.sortBy(scoredGroups, sg => sg.score).reverse()*
      *const sorted = sortedScoredGroups.map(ssg => ssg.group)*
      *mutations.push(candidate)*
      *for (let i = 0; i < ofSize; i++) {*
        *if (withGroupLeaders && i == 0) continue;*
        *for (let j = ofSize; j < totalSize; j++) {*
          *if (withGroupLeaders && j % ofSize == 0) continue;*
          *mutations.push(score(swap(sorted, i, j), weights))*
        *}*
      *}*
      *for (let i = 0; i < RANDOM_MUTATIONS; i++) {*
        *mutations.push(score(generatePermutation(), weights))*
      *}*
    *})*
    *return mutations;*
  *}*
  
The generateMutations function generates new candidate configurations by mutating the provided candidates.
It creates mutations by swapping players in and out of the most costly groups and
adding random permutations to break out of local peaks.

  *function swap(groups, i, j) {*
    *const copy = groups.map(group => group.slice())*
    *copy[Math.floor(i / ofSize)][i % ofSize] = groups[Math.floor(j / ofSize)][j % ofSize]*
    *copy[Math.floor(j / ofSize)][j % ofSize] = groups[Math.floor(i / ofSize)][i % ofSize]*
    *return copy*
  *}*

The swap function swaps two players in the groups configuration.

  *function updateWeights(round, weights) {*
    *for (const group of round) {*
      *forEachPair(group, (a, b) => {*
        *weights[a][b] = weights[b][a] = (weights[a][b] + 1)*
      *})*
    *}*
  *}*

The updateWeights function updates the weights matrix based on the provided round
configuration by increasing the weight for each pair of players grouped together.

  *const weights = _.range(totalSize).map(() =>* *_.range(totalSize).fill(0))*
  *if (withGroupLeaders) {*
    *for (let i = 0; i < groups - 1; i++) {*
      *for (let j = i + 1; j < groups; j++) {*
        *weights[i][j] = weights[j][i] = Infinity;*
      *}*
    *}*
  *}*

  *forbiddenPairs.forEach(group => {*
    *forEachPair(group, (a, b) => {*
      *if (a >= totalSize || b >= totalSize) return*
      *weights[a][b] = weights[b][a] = Infinity*
    *})*
  *})*

  *discouragedGroups.forEach(group => {*
    *forEachPair(group, (a, b) => {*
      *if (a >= totalSize || b >= totalSize) return*
      *weights[a][b] = weights[b][a] = (weights[a][b] + 1)*
    *})*
  *})*

Initializes the weights matrix and applies initial constraints.
If withGroupLeaders is set, it forbids combinations of group leaders.
It also applies forbidden pairs and discouraged groups to the weights matrix.

  *const rounds = []*
  *const roundScores = []*

  *for (let round = 0; round < forRounds; round++) {*
    *let topOptions = _.range(5).map(() =>* *score(generatePermutation(), weights))*
    *let generation = 0*
    *while (generation < GENERATIONS && topOptions[0].total > 0) {*
      *const candidates = generateMutations(topOptions, weights)*
      *let sorted = _.sortBy(candidates, c => c.total)*
      *const bestScore = sorted[0].total*
      *topOptions = sorted.slice(0, sorted.findIndex(opt => opt.total > bestScore))*
      *topOptions = _.shuffle(topOptions).slice(0, MAX_DESCENDANTS_TO_EXPLORE)*
      *generation++;*
    *}*
    *const bestOption  = topOptions[0]*
    *if (withGroupLeaders) {*
      *bestOption.groups.sort((a, b) => a[0] - b[0]);*
    *}*
    *rounds.push(bestOption.groups)*
    *roundScores.push(bestOption.total)*
    *updateWeights(bestOption.groups, weights)*
    *onProgress({*
      *rounds,*
      *roundScores,*
      *weights,*
      *done: (round+1) >= forRounds,*
    *})*
  *}*
*}*

The main loop of the genetic algorithm.
It generates initial permutations, mutates them over generations,
and selects the best candidates.
It updates the weights and reports progress after each round.

*function forEachPair(array, callback) {*
  *for (let i = 0; i < array.length - 1; i++) {*
    *for (let j = i + 1; j < array.length; j++) {*
      *callback(array[i], array[j])*
    *}*
  *}*
*}*
A utility function that iterates over all unique pairs in an array and applies a callback to each pair.

These series of code implement a genetic algorithm to solve the social golfer problem,
which involves organizing players into groups over multiple rounds such that
certain constraints are satisfied, and pairs are grouped together as few times as possible.
The algorithm uses permutations, mutations, and weights to explore possible configurations,
aiming to minimize the total cost of grouping players while respecting forbidden and discouraged pairs.
The process is iterative, running over a specified number of generations and rounds,
updating weights based on grouping history, and reporting progress through a callback function.
