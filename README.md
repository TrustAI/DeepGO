
 
# DeepGO: Reachability Analysis of Deep Neural Networks with Provable Guarantees

Reachability Analysis of Deep Neural Networks with Provable Guarantees

Authors: Wenjie Ruan, Xiaowei Huang, Marta Kwiatkowska

27th International Joint Conference on Artificial Intelligence (IJCAI'18)

The long version can be found in https://arxiv.org/abs/1805.02242 

Email: wenjie.ruan@cs.ox.ac.uk

# Abstract
Verifying correctness of deep neural networks (DNNs) is challenging. We study a generic reachability problem for feed-forward DNNs which, for a given set of inputs to the network and a Lipschitz-continuous function over its outputs, computes the lower and upper bound on the function values. Because the network and the function are Lipschitz continuous, all values in the interval between the lower and upper bound are reachable. We show how to obtain the safety verification problem, the output range analysis problem and a robustness measure by instantiating the reachability problem. We present a novel algorithm based on adaptive nested optimisation to solve the reachability problem. The technique has been implemented and evaluated on a range of DNNs, demonstrating its efficiency, scalability and ability to handle a broader class of networks than state-of-the-art verification approaches. 


# Sample Results

![alt text](Capture1.PNG)

![alt text](Capture2.PNG)

![alt text](Capture3.PNG)


# Software

Matlab 2018a

Neural Network Toolbox

Image Processing Toolbox

Parallel Computing Toolbox

# Run

### Folder "ExperimentCode" contains two sub-folders:

Experiment1_FunctionNN:

Code for the experiment 6.1 in the paper, Lipschitz constant is set before the searching

Experiment2_DNN_MNIST:

Code for the experiment 6.2 in the paper, Lipschitz constant is dynamically estimated during the searching

### Folder "ExperimentResults" contains more experimental results


# Citation
```
@article{RHK2018,
	Author = {Wenjie Ruan and Xiaowei Huang and Marta Kwiatkowska},
	Journal = { The 27th International Joint Conference on Artificial Intelligence (IJCAI'18)},
	Title = {Reachability Analysis of Deep Neural Networks with Provable Guarantees},
	Year = {2018}}
```
or

```
@article{RHK2018arXiv,
	Author = {Wenjie Ruan and Xiaowei Huang and Marta Kwiatkowska},
	Journal = {arXiv preprint arXiv:1805.02242},
	Title = {Reachability Analysis of Deep Neural Networks with Provable Guarantees},
	Year = {2018}}
```


# Acknowledgement:
Here we would like to acknowledge Prof. Yaroslav Sergeyev's discussion and help on the convergence analysis.
```
@article{grishagin2018convergence,
  title={Convergence conditions and numerical comparison of global optimization methods based on dimensionality reduction schemes},
  author={Grishagin, Vladimir and Israfilov, Ruslan and Sergeyev, Yaroslav},
  journal={Applied Mathematics and Computation},
  volume={318},
  pages={270--280},
  year={2018},
  publisher={Elsevier}
}
```





