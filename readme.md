# Overview

This work was done as part of a coding test for a job that I applied for.  The exact requirements were:

## Requirements

Program a model of a vending machine. It should at least satisfy the following requirements:

* Contains various products, each of which can be retrieved by entering in the correct amount of money, and then punching in the code for that item
* Dispenses change after making a purchase
* Has a cancel button that returns the user's change
* Ability to stock/restock items in the machine
* Any other functionality that you think a vending machine should have!

It is not required that you build any sort of user interface, but there should be some demonstration of the model’s functionality.  Write this code as if it were going into production.

## My Approach

I wrote this as a command line driven Ruby project that you communicate with along the lines of an old school text adventure.  There are a series of verbs like "buy", "pay" and others.  Due to implementation of an interactive, text adventure style interface, some of the internals are a bit masked at the interface level (example - there's no need to type in the amount of money; it is automatically removed from the customer's wallet).

## Directions

Here is how to run the code:

1.  Clone this project down to your local machine.
2.  There should be no gems or dependencies; if you have a Ruby development environment, it should just work.
3.  If you don't have a Ruby development environment then there is an accompanying screencast which illustrates the functionality as a .mp4 file.
4.  If you are running it then cd into your cloned repo and then run **ruby vending_machine.rb**
5.  Tests can be run with 

## About the Screencast

If you watch the screencast, you'll notice 1 bug where the cancel routine failed to update the customer's wallet with the money.  That has been fixed but I did not re-record the screencast since I actually, except for that one thing, had a good recording.  This was due to two lines that hadn't been implemented but are now in place.  This is also illustrated in the screenshot cancel.png in the repo which shows the overall flow and the money returning to the customer's wallet.