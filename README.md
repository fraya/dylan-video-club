# dylan-video-club
Example from 'Refactoring' book of Martin Fowler.

## Video-club example

I re-do the first example in Martin Fowler's book 
"Refactoring: Improving the design of existing code" 
edition 1, in [Opendylan][opendylan].

## Start diagram

The initial interaction for the method `statement` 
is shown in the next figure:

```mermaid
sequenceDiagram
    actor User
    User ->>customer: statement
    loop for all rentals
        customer->>rental: rental-movie
        customer->>movie: movie-price-code
        customer->>rental: rental-days-rented
    end
```

## Finish diagram

The translation between a multi-method Object Oriented
programming and the sequence diagram is not 1 to 1.
For instance `category` is not a class but a symbol.

```mermaid
sequenceDiagram
    actor User
    User ->>+statement: print-statement
    statement->>+customer: charge
    loop for all rentals
        customer->>+rental: charge
        rental->>+movie: charge-by-movie-and-days
        movie->>+category: charge-by-category-and-days
        category-->-movie: amount
        movie-->>-rental: amount
        rental-->>-customer: amount
    end
    statement->>+customer: rental-points
    loop for all rentals
        customer->>+rental: renter-points
        rental->>+movie: renter-points-by-movie-and-days
        movie-->>-rental: points
        rental-->>-customer: points 
    end
```

[opendylan]: https://opendylan.org