# Testing Strategy
There can be two ways to make the test: 

i) Have the output of an older version of the code with low size parameters
so it is not so large.

ii) actually compile and run an older version of the code; in which case we 
need store just the older source code.

## Stored Code
Now we would have to have this older version of the code. But actually
we do have access to this easily on git. I wonder if people do that.
So what we could do with the test is check out the older version of the 
code that we know works (because pushes only work with a test), compile
that and calculate the output.

This has the advantage that we do not need to store any outputs.

A possible issue with this is that checking out will change your working directory
so this test will only be possible in push situations, not before a commit. There
is probably a way to do it.

### Git worktree

We can create a copy of an old commit repo using git worktree. We can use this version of
the repo to generate some outputs, and then test the current commit or current working repo
against them. It would be better if we test the working tree because then we can nicely 
incorporate `git restore` into future workflows.

- Tag good stable commit version that all future tests will be done against.

- Test the git worktree testing workflow

- Automate creation of woktree old commit and production of output, along with test against current code.

- Incorporate this into make file.

## Stored Output

In this method we would simply save in our tests folder the output of some stable working version of the
code. We could then test the current version of the code by simply looking at diffs between our code output
and this saved output. This would be the easiest tests to implement, but would take up alot of space.

### Small outputs

An optimised version of storing the output could be achieved where only some details of the stable output
are saved. This however would necessitate more complicated comparison code than a simple diff.

### Test just key points

We really only need to test the indium atoms and perhaps the naming of
a few Nitrogen atoms. We could grep out the indium and nitrogen atoms
and test them, and we could look at the cell parameters.
