# HDXLAlgebraicUtilities

Support for anonymous sums, "better tuples", and miscellaneous "collection-combinators".

## Remarks

Consider this package a *successful* (mad) "science experiment": it's at once perfectly-functional but also thoroughly-impractical (at least with the current iteration of Swift's compiler). The impracticality arises from two distinct issues: (a) code bloat and (b) performance.

## Future Directions

On the one hand, I am strongly considering refactoring things so that this package has multiple build products, organized roughly like so:

- multiple smaller, narrow-purpose libraries
- an "omnibus", all-in-one/convenience library bundling the above

The catch, here, is in how to break things down into multiple smaller, narrow-purpose libraries: the structure of the code makes "one library per arity" the most-natural choice, but doing it that way would still bring in a lot of probably-unwanted code bloat; you just want `Chain5Collection`, but wind up with about a dozen other arity-5 collections, too.

A more-granular strategy would be to, say, split things down until we're at the level of individual collection archetypes:

- `HDXLAlgebraicUtilities` containing the core algebraic glue-and-boilerplate
- `HDXLChainCollections` containing the chain collections
- `HDXLCartesianProductCollections` containing the cartesian product collections

...and so on and so forth. Note that--presumably--the packages like `HDXLChainCollections` would, themselves, be organized in the per-arity style: one sublibrary per arity, together with a convenience omnibus library.

That's a lot of administrative work and--arguably--it's also *necessary* administrative work to transform this code from "intellectual curiosity" to "deployable functionality". That said, still I hope to get there and do that, but am holding off until I have a clearer picture of the target granularity.