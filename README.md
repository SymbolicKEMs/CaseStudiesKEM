# Keeping Up with the KEMs

This repository contains all case studies from

`Keeping Up with the KEMs: Stronger Security Notions for KEMs and automated analysis of KEM-based protocols`

and the means to reproduce them.

## Structure

All Tamarin protcol models can be found in the folders

```
Kyber
OnepassAKE
PQSPDM
Sigma_Zero
```

and the precomputed Results can be found in `precomputed_RES`

------ 

## Dependencies

For convenience, we provide an image that contains all dependencies, which
can be run either via `docker` or `podman`. We provide scripts that use `podman`.

Run

```
./build-container.sh
```
to locally build the container image. Then start the container via

```
./start-container.sh
```

This will launch the container in the current directory.

### Manual Installation of Dependencies

#### Tamarin Prover

We rely on the [Tamarin prover](https://tamarin-prover.com/) version 1.8.0. on the master branch

```
tamarin-prover 1.8.0, (C) David Basin, Cas Cremers, Jannik Dreier, Simon Meier, Ralf Sasse, Benedikt Schmidt, 2010-2023

This program comes with ABSOLUTELY NO WARRANTY. It is free software, and you
are welcome to redistribute it according to its LICENSE, see
'https://github.com/tamarin-prover/tamarin-prover/blob/master/LICENSE'.

maude tool: 'maude'
 checking version: 3.1. OK.
 checking installation: OK.
Generated from:
Tamarin version 1.8.0
Maude version 3.1
Git revision: UNKNOWN, branch: master
Compiled at: 2024-04-16 13:02:34.37557056 UTC
```

Details regarding installation can be found on [Tamarin's webpage](https://tamarin-prover.com/manual/master/book/002_installation.html)

#### Python Dependencies

To install all dependencies to execute the case studies, run

```
apt-get install python3
apt-get install python3-pip
pip3 install tabulate matplotlib graphviz
```

-------

## Instructions to reproduce the results

We run the full analysis on a computing cluster with an Intel(R) Xeon(R) CPU E5-4650L 2.60GHz machine with 1TB of RAM and 4
threads per Tamarin call. The execution time of our full methodology was approximately ∼16h30m.

### Main analysis

To execute all case studies run

```
./analysis.sh all
```

Alternativley, to execute single case studies, replace the `all` with `onepass`,`kyber`,`sigma`,`perfectsigma` or `pqspdm`.

The results can then be compared to the results in `precomputed_RES`.

The results are saved as `.csv` files and can be found in folders named after the case study and the KEM configuration used. 
The `.csv` files contain a list, that for each lemma of the protocol models saves the proof results and timing information. For
more details we refer to the `Methodology` section in the [full paper](https://eprint.iacr.org/2023/1933.pdf)

### Finding the right binding properties

To search the minimal needed binding properties of the lemmas mentioned in Table 4 of the paper,
execute

```
./Onepass.sh
```

```
./kyber.sh
```

```
./sigma.sh
```

```
./sigma-perfect.sh
```

and you can find the results as `.pdf`-files in the respective protocol folders. You can find the precomputed `.pdf`-files
in the same folder as well. Here, green nodes refer to a lemma being proven under the combination of binding properties, red
nodes denote an attack being found, while yellow nodes shows non-termination in the given time frame.

#### Oracle Tests

To see that the hierarchy of binding properties from Figure 7 also in the symbolic model
one can also run

```
python3 test_cases.py --test
```

which will run all combinations of binding properties on Tamarin models capturing
the binding games from Figure 5 and Figure 6.

## KEM Library

All details on how to use the KEMlibrary can be found [here](README_KEMlibrary.md)

-------

### Authors

Cas Cremers, Alexander Dax, and Niklas Medinger

CISPA Helmholtz Center for Information Security (2024)

