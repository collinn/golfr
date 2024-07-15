# geneticSolver #

```
const GENERATIONS = 30
const RANDOM_MUTATIONS = 2
const MAX_DESCENDANTS_TO_EXPLORE = 100
```

These are constants defining the parameters for the genetic algorithm.
GENERATIONS sets the number of generations for the genetic algorithm,
RANDOM_MUTATIONS defines the number of random mutations to introduce in each generation,
and MAX_DESCENDANTS_TO_EXPLORE limits the number of descendant permutations to explore in each generation.

```
function geneticSolver(
  groups, ofSize, forRounds, withGroupLeaders,
  forbiddenPairs=[], discouragedGroups=[], onProgress
  ) {
  const totalSize = groups ofSize;
```

This function is the main solver for the social golfer problem.
It takes the number of groups, the size of each group, the number of rounds,
a flag for group leaders, arrays for forbidden pairs and discouraged groups,
and a callback function for progress updates.
totalSize calculates the total number of players.

```
  function score(round, weights) {
    const groupScores = round.map(group => {
      let groupCost = 0
      forEachPair(group, (a, b) => groupCost += Math.pow(weights[a][b], 2))
      return groupCost
    })
    return {
      groups: round,
      groupsScores: groupScores,
      total: groupScores.reduce((sum, next) => sum + next, 0),
    }
  }
```

The score function calculates the cost of a given round configuration based on weights. 
It iterates through each group, computes the cost of each pair within the group
using the weights matrix, and returns an object containing the group configuration,
individual group scores, and the total score.

```
  function generatePermutation() {
    const shuffleStart = withGroupLeaders ? groups : 0;
    const shuffledPeople = _.shuffle(_.range(shuffleStart, groups  ofSize));
    const shuffledPerGroup = shuffledPeople.length / groups;
    return _.range(groups).map(i => {
      const group = [];
      if (withGroupLeaders) {
        group.push(i);
      }
      group.push(...shuffledPeople.slice(i  shuffledPerGroup, (i+1)  shuffledPerGroup));
      return group;
    });

  }
```

The generatePermutation function creates a shuffled configuration of players into groups.
If withGroupLeaders is set, the first groups players are assigned deterministically to each group.
The rest are shuffled and divided into groups.

```
  function generateMutations(candidates, weights) {
    const mutations = []
    candidates.forEach(candidate => {
      const scoredGroups = candidate.groups.map((g, i) => ({group: g, score: candidate.groupsScores[i]}))
      const sortedScoredGroups = _.sortBy(scoredGroups, sg => sg.score).reverse()
      const sorted = sortedScoredGroups.map(ssg => ssg.group)
      mutations.push(candidate)
      for (let i = 0; i < ofSize; i++) {
        if (withGroupLeaders && i == 0) continue;
        for (let j = ofSize; j < totalSize; j++) {
          if (withGroupLeaders && j % ofSize == 0) continue;
          mutations.push(score(swap(sorted, i, j), weights))
        }
      }
      for (let i = 0; i < RANDOM_MUTATIONS; i++) {
        mutations.push(score(generatePermutation(), weights))
      }
    })
    return mutations;
  }
```

The generateMutations function generates new candidate configurations by mutating the provided candidates.
It creates mutations by swapping players in and out of the most costly groups and
adding random permutations to break out of local peaks.

```
  function swap(groups, i, j) {
    const copy = groups.map(group => group.slice())
    copy[Math.floor(i / ofSize)][i % ofSize] = groups[Math.floor(j / ofSize)][j % ofSize]
    copy[Math.floor(j / ofSize)][j % ofSize] = groups[Math.floor(i / ofSize)][i % ofSize]
    return copy
  }
```

The swap function swaps two players in the groups configuration.

```
  function updateWeights(round, weights) {
    for (const group of round) {
      forEachPair(group, (a, b) => {
        weights[a][b] = weights[b][a] = (weights[a][b] + 1)
      })
    }
  }
```

The updateWeights function updates the weights matrix based on the provided round
configuration by increasing the weight for each pair of players grouped together.

```
  const weights = _.range(totalSize).map(() => _.range(totalSize).fill(0))
  if (withGroupLeaders) {
    for (let i = 0; i < groups - 1; i++) {
      for (let j = i + 1; j < groups; j++) {
        weights[i][j] = weights[j][i] = Infinity;
      }
    }
  }

  forbiddenPairs.forEach(group => {
    forEachPair(group, (a, b) => {
      if (a >= totalSize || b >= totalSize) return
      weights[a][b] = weights[b][a] = Infinity
    })
  })

  discouragedGroups.forEach(group => {
    forEachPair(group, (a, b) => {
      if (a >= totalSize || b >= totalSize) return
      weights[a][b] = weights[b][a] = (weights[a][b] + 1)
    })
  })
```

Initializes the weights matrix and applies initial constraints.
If withGroupLeaders is set, it forbids combinations of group leaders.
It also applies forbidden pairs and discouraged groups to the weights matrix.

```
  const rounds = []
  const roundScores = []

  for (let round = 0; round < forRounds; round++) {
    let topOptions = _.range(5).map(() => score(generatePermutation(), weights))
    let generation = 0
    while (generation < GENERATIONS && topOptions[0].total > 0) {
      const candidates = generateMutations(topOptions, weights)
      let sorted = _.sortBy(candidates, c => c.total)
      const bestScore = sorted[0].total
      topOptions = sorted.slice(0, sorted.findIndex(opt => opt.total > bestScore))
      topOptions = _.shuffle(topOptions).slice(0, MAX_DESCENDANTS_TO_EXPLORE)
      generation++;
    }
    const bestOption  = topOptions[0]
    if (withGroupLeaders) {
      bestOption.groups.sort((a, b) => a[0] - b[0]);
    }
    rounds.push(bestOption.groups)
    roundScores.push(bestOption.total)
    updateWeights(bestOption.groups, weights)
    onProgress({
      rounds,
      roundScores,
      weights,
      done: (round+1) >= forRounds,
    })
  }
}
```

The main loop of the genetic algorithm.
It generates initial permutations, mutates them over generations,
and selects the best candidates.
It updates the weights and reports progress after each round.

```
function forEachPair(array, callback) {
  for (let i = 0; i < array.length - 1; i++) {
    for (let j = i + 1; j < array.length; j++) {
      callback(array[i], array[j])
    }
  }
}
```

A utility function that iterates over all unique pairs in an array and applies a callback to each pair.

`geneticSolver` implements a genetic algorithm to solve the social golfer problem,
which involves organizing players into groups over multiple rounds such that
certain constraints are satisfied, and pairs are grouped together as few times as possible.
The algorithm uses permutations, mutations, and weights to explore possible configurations,
aiming to minimize the total cost of grouping players while respecting forbidden and discouraged pairs.
The process is iterative, running over a specified number of generations and rounds,
updating weights based on grouping history, and reporting progress through a callback function.

# seatingChart #

```
const _ = require('lodash')
const {Record, List, Set, Stack} = require('immutable')
```

Imports the `lodash` library and several classes from the `immutable` library,
which provides immutable data structures.

```
const State = Record({
  finishedRounds: List(),
  groups: List(),
  nextPlayer: 0,
  totalCost: 0,
  weights: null,
})
```

Defines a `State` record using `immutable`'s `Record`.
It has properties `finishedRounds`, `groups`, `nextPlayer`, `totalCost`, and
`weights` initialized with default values.

```
function printState(state) {
  return JSON.stringify(state.groups.toJS()) + ', cost ' + state.totalCost
}
```

Converts the `groups` property of a state to a plain JavaScript object and
returns a string representation of the state, including its `totalCost`.

```
function printWeights(weights) {
  return weights.toJS().map(row => row.join('  ')).join('\n')
}
```

Converts the `weights` matrix to a plain JavaScript object and returns a string
representation with each row joined by spaces.

```
module.exports = function seatingChart({
  studentNames,
  totalGroups,
  seatsPerGroup,
  rounds,
}) {
```

Exports a function `seatingChart` that takes an object with properties:
`studentNames`, `totalGroups`, `seatsPerGroup`, and `rounds`.

```
  const playerCount = studentNames.length
```

Calculates the number of students from the length of `studentNames`.

```
  function exploreState(state) {
    const {weights, nextPlayer} = state;
    if (nextPlayer >= playerCount) {
      return [
        state.merge({
          finishedRounds: state.finishedRounds.push(state),
          groups: List(),
          nextPlayer: 0,
        })
      ]
    }
```

The `exploreState` function generates new states by attempting to place the 
next player into existing or new groups.
If all players are seated, it finalizes the round and resets the `groups` and `nextPlayer`.

```
  const childStates = []
    for (let i = 0; i < state.groups.size; i++) {
      const group = state.groups.get(i)
      if (group.size < seatsPerGroup) {
        const cost = group.reduce((cost, player) => {
          return cost + weights.getIn([player, nextPlayer])
        }, 0)
        let newWeights = state.weights
        group.forEach(member => {
          newWeights = newWeights
            .setIn([nextPlayer, member], 1)
            .setIn([member, nextPlayer], 1)
        })
        childStates.push(state.merge({
          groups: state.groups.set(i, group.add(nextPlayer)),
          nextPlayer: nextPlayer + 1,
          totalCost: state.totalCost + cost,
          weights: newWeights
        }))
      }
    }
```

Iterates over existing groups and tries to place the next player into each group,
updating the total cost and weights accordingly.

````
  if (state.groups.size < totalGroups) {
    childStates.push(state.merge({
        groups: state.groups.push(Set.of(state.nextPlayer)),
        nextPlayer: state.nextPlayer + 1,
        weights: weights
      }))
    }
```

If there are available groups, adds a new group with the next player.

```
  return childStates
  }
```

Returns the list of new child states generated from the current state.

```
  const initialState = new State({
    weights: List(_.range(playerCount).map(() => List(_.range(playerCount).fill(0))))
  })
  let unexploredStates = Stack()
```

Initializes the `initialState` with a weights matrix filled with zeros and
creates an empty `Stack` for unexplored states.

```
  let currentState = initialState;
  do {
    unexploredStates = unexploredStates.unshiftAll(exploreState(currentState))
    unexploredStates = unexploredStates.sort((a, b) => a.totalCost > b.totalCost ? 1 : a.totalCost === b.totalCost ? 0 : -1)
    currentState = unexploredStates.first()
    unexploredStates = unexploredStates.shift()
  } while (currentState.finishedRounds.size < rounds)
```

The main loop that explores states until the required number of rounds is reached.
It adds new states to the stack, sorts them by total cost, and selects the best state to explore next.

```
  currentState.finishedRounds.forEach(round => {
    console.log(printState(round));
  })
  console.log(printWeights(currentState.weights))
```

Prints the final state of each round and the weights matrix.

```
  return {
    conflicts: currentState.totalCost,
    rounds: [
      currentState.groups.toJS().map(group => group.map(playerIndex => studentNames[playerIndex]))
    ]
  }
}
```

Returns an object containing the total conflicts (cost) and the final seating chart with student names.

`seatingChart` solves the seating chart problem using a search algorithm that explores
possible seating configurations.
It initializes with a given number of groups, seats per group, and rounds, and
iteratively generates new states by placing students into groups.
The goal is to minimize the total cost, calculated based on a weights matrix that
tracks conflicts (students seated together previously).
The algorithm explores states until the desired number of rounds is completed,
selecting the best configurations based on the total cost.
The final result includes the total number of conflicts and the seating chart for each round.

# worker #
### Detailed Explanation

```
self.importScripts('https://cdn.jsdelivr.net/npm/lodash@4.17.4/lodash.min.js')
self.importScripts('geneticSolver.js')
```

The `importScripts` function is used to import external scripts into the Web Worker environment.
Here, it imports the Lodash library from a CDN and a local `geneticSolver.js` script.

```
self.addEventListener('message', function(e) {
```

Registers an event listener for the `message` event, which is triggered when the
Web Worker receives a message from the main thread.

```
  const {groups, ofSize, forRounds, withGroupLeaders, forbiddenPairs, discouragedGroups} = e.data
```

Destructures the incoming data from the message event.
The data includes parameters required to run the `geneticSolver` function: 
`groups`, `ofSize`, `forRounds`, `withGroupLeaders`, `forbiddenPairs`, and `discouragedGroups`.

```
  geneticSolver(groups, ofSize, forRounds, withGroupLeaders, forbiddenPairs, discouragedGroups, (results) => {
    self.postMessage(results)
  })
```

Calls the `geneticSolver` function with the provided parameters. 
The last parameter is a callback function that receives the results of the computation
and sends them back to the main thread using `self.postMessage`.

```
}, false)
```

Closes the event listener registration, with `false` indicating that the event
should be captured in the bubbling phase.

`worker` defines a Web Worker script that performs computations using the `geneticSolver` function. 
The script imports the necessary dependencies (`lodash` and `geneticSolver.js`) and
listens for messages from the main thread.
When a message is received, it extracts the necessary parameters from the message
data and invokes the `geneticSolver` function with those parameters.
The results of the computation are sent back to the main thread via a callback function.
This setup allows the computationally intensive `geneticSolver` function to run
in a separate thread, preventing the main thread from becoming unresponsive.
