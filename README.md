
<h1 align="center">
  Earch Conductivity | LANL
  <br>
</h1>

<h4 align="center">An application of the Quebec 5-layer model for GIC-induced disturbance modelling</h4>

<p align="center">
  <a href="#abstract">Introduction</a> •
  <a href="#how-to-use">How To Use</a> •
  <a href="#paper">Paper</a> •
  <a href="#training-figures">Training Figures</a> •
  <a href="#related-work">Related Work</a> •
  <a href="#support">Support</a> •
  <a href="#credits">Credits</a>
</p>

![screenshot](./res/demo.gif)

## Introduction
This project was done as part of the Computing in Research internship under the mentorship of Art Barnes from the Los Alamos National Lab. It attempts to recreate the Boteler *2019 Analytic Calculation of Geoelectric Fields due to Geomagnetic Disturbances: A Test Case* paper and applies it to predict the effects of Geomagnetic Disturbances on power grids. 



## How To Use
This repo provides the code to recreate the results of the Boteler 2019 paper or run the model on an arbitrary dataset. 

To clone and run this application, you will need Julia and Python. After installing both, from your command line:

```bash
# Clone this repository
$ git clone https://github.com/nikhilanayak/EarthConductivity
 •
# Go into the repository
$ cd EarthConductivity

# Install dependencies
$ julia install.jl

# See the params for the main program
$ julia transfer_sim.jl

# Recreate the Boteler 2019 results
$ python transfer_sim.jl recreate

# Run the model on a dataset (ex: data.txt) and visualize results
$ julia transfer_sim.jl load data.txt > out.txt
$ python plot.py
```

> **Note**
> This code was developed/tested on Linux but it should work on all platforms. 

## Paper

To compile the paper, run the following commands (with pdflatex and biber installed):
```bash
$ cd Latex
$ ./build.sh
```

## Related Work

[Boteler 2019](https://ieeexplore.ieee.org/abstract/document/8859181) - The project that this project was based on


## Support

If you used this project or any of its code, or had any questions, shoot me an email at nikhil.a.nayak@gmail.com.


## Credits

This work was done as part of the Computing in Research Internship. Thank you to Dr. Mark Galassi for hosting the internship and Art Barnes for mentoring me throughout the internship


## License
MIT