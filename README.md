# Radon Transform and Inverse Radon Transform

# Goal 

To Generate CT raw data (sinograms) of objects and to reconstruct the tomographic images

# Source images

* 128 by 128 simulated head phantom

  ![128Phantom](source_images/128Phantom.png "128Phantom")

* 128 by 128 two square phantom

  ![Sinogram_Source_-_Two_Squares_Phantom](source_images/Sinogram_Source_-_Two_Squares_Phantom.png "Sinogram_Source_-_Two_Squares_Phantom")

# Radon transform results

* 128 by 128 simulated head phantom

![Sinogram-128_Phantom](RdTr_results/Sinogram-128_Phantom_physical_128views_physical.png "Sinogram-128_Phantom")


* 128 by 128 two square phantom

![Sinogram-Two_Squares_Phantom](RdTr_results/Sinogram-Two_Squares_Phantom_128views_physical.png "Sinogram-Two_Squares_Phantom")

# Inverse Radon transform results

## Filtered Back Projection (FBP)

* 128 by 128 simulated head phantom

    Reconstruct image and animation over the project angles

<p align="center">
    <img src=iRdTr_results/128phantom_rec_physical.png>
</p>

<p align="center">
    <img src=iRdTr_results/128phantom_rec_physical.gif>
</p>

* 128 by 128 two square phantom

    Reconstruct image and animation over the project angles

<p align="center">
    <img src=iRdTr_results/two_square_rec_physical.png>
</p>

<p align="center">
    <img src=iRdTr_results/two_sqare_rec_physical.gif>
</p>