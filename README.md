Title         : Radon Transform and Inverse Radon Transform
Logo          : True

[TITLE]

# Goal 

To Generate CT raw data (sinograms) of objects and to reconstruct the tomographic images

# Source images

* 128 by 128 simulated head phantom

  ![128Phantom]
  [128Phantom]: source_images/128Phantom.png "128Phantom" { width:auto; max-width:90% }

* 128 by 128 two square phantom

  ![Sinogram_Source_-_Two_Squares_Phantom]
  [Sinogram_Source_-_Two_Squares_Phantom]: source_images/Sinogram_Source_-_Two_Squares_Phantom.png "Sinogram_Source_-_Two_Squares_Phantom" { width:auto; max-width:90% }

# Radon transform results

* 128 by 128 simulated head phantom

![Sinogram-128_Phantom]

[Sinogram-128_Phantom]: RdTr_results/Sinogram-128_Phantom.png "Sinogram-128_Phantom" { width:auto; max-width:90% }


* 128 by 128 two square phantom

![Sinogram-Two_Squares_Phantom]

[Sinogram-Two_Squares_Phantom]: RdTr_results/Sinogram-Two_Squares_Phantom.png "Sinogram-Two_Squares_Phantom" { width:auto; max-width:90% }

# Inverse Radon transform results

* 128 by 128 simulated head phantom

  Reconstruct image
 
  ![two_square_rec]

  [two_square_rec]: iRdTr_results/two_square_rec.png "two_square_rec" { width:auto; max-width:90% }

  Animation over the project angle

  ![two_square_rec_gif]
  [two_square_rec_gif]: iRdTr_results/two_sqare_rec.gif "two_square_rec_gif"{ width:auto; max-width:90% }

* 128 by 128 two square phantom

  Reconstruct image
 
  ![128phantom_rec]

  [128phantom_rec]: iRdTr_results/128phantom_rec.png "two_square_rec" { width:auto; max-width:90% }

  Animation over the project angle

  ![128phantom_rec_gif]
  [128phantom_rec_gif]: iRdTr_results/128phantom_rec.gif "two_square_rec_gif"{ width:auto; max-width:90% }
