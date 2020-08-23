# vis3p 

## About
vis3p is a research project in nonlinear mathematical optimization. vis3p computes and draws valid linear inequalities for sets that are given by polynomial inequalities, using a method known as sos programming; drawing is limited to two dimensions. This is joint work with [Anita Schöbel](https://www.mathematik.uni-kl.de/opt/personen/leitung/schoebel), the corresponding paper has now been published in [JOTA (Open Access)](https://link.springer.com/article/10.1007/s10957-020-01736-4).

## Example output

A typical output looks like the following, for an explanation see below.

![alt text](docs/bounded_high.png "Example drawing")

In the example, two polynomials have been provided by the user: h_1 and h_2. We are interested in the set of nonnegative points of the h_i. For h_1, this is the full unit circle, for h_2, it is the epigraph of a cubic. Intersecting both gives the set of interest: S, which is annotated in the image. For simplicity, vis3p plots the vanishing set of the h_i -- those points where h_i is zero -- instead of the nonnegative points. In this case, the unit sphere (the zero set of h_1) and a cubic (the zero set of h_2). The purpose of vis3p is to compute a half-space containing S, or differently put, to compute a valid linear inequality for S, that is as close as possible to a given point q in S, marked with a star in the plot. vis3p solves this task using a hierarchy of approximating sos programs. The computed valid inequality of a fixed level in this hierarchy is depicted in the figure.

## Requirements

You need the following software installed. I specify the software version that worked for me; it may work with other versions. All MATLAB tools need to be added to the MATLAB search path.

* [MATLAB 2016b](https://www.mathworks.com) as computing environment
* [Symbolic Math Toolbox](https://mathworks.com/products/symbolic.html) to work with symbolic polynomials
* [SOSTOOLS 3.01](https://www.cds.caltech.edu/sostools) a MATLAB toolbox to convert sos programs into semidefinite programs
* [SeDuMi 1.3](http://sedumi.ie.lehigh.edu) semidefinite solver written in MATLAB
* [export_fig 99d1c37a9600abde20150ed0534b984241e5acc3](https://github.com/altmany/export_fig) is a MATLAB tool to export plots to eps-files

Note that vis3p has only been tested on Debian jessie (GNU/Linux). Some features like system calls (e.g., git integrity check for reproducible plots) may only work on Linux.

## Installation

* Clone this git repo
* Change the working directory to the repo path
* Start MATLAB
* Run vis3p to plot the scenarios (cf. the `Scenarios` folder) by invoking `SolveAndDrawAllScenarios` from the MATLAB command prompt

## What does the name vis3p stand for?
Valid Inequalities for Semi-algebraic Sets using Sos Programming. 
