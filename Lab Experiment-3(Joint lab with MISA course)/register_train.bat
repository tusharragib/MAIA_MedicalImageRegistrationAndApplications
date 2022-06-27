elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1001.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/01/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/01/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/01/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/01/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/01/bspline

transformix -in training-set/training-labels/1001_3C.nii -out training-set/registered_labels/01/rigid -tp training-set/registered_images/01/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/01/rigid/result.nii.gz -out training-set/registered_labels/01/affine -tp training-set/registered_images/01/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/01/affine/result.nii.gz -out training-set/registered_labels/01/bspline -tp training-set/registered_images/01/bspline/TransformParameters.0.txt 
-----------------
elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1002.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/02/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/02/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/02/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/02/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/02/bspline

transformix -in training-set/training-labels/1002_3C.nii -out training-set/registered_labels/02/rigid -tp training-set/registered_images/02/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/02/rigid/result.nii.gz -out training-set/registered_labels/02/affine -tp training-set/registered_images/02/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/02/affine/result.nii.gz -out training-set/registered_labels/02/bspline -tp training-set/registered_images/02/bspline/TransformParameters.0.txt 
---------------------------

elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1006.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/06/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/06/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/06/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/06/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/06/bspline

transformix -in training-set/training-labels/1006_3C.nii -out training-set/registered_labels/06/rigid -tp training-set/registered_images/06/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/06/rigid/result.nii.gz -out training-set/registered_labels/06/affine -tp training-set/registered_images/06/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/06/affine/result.nii.gz -out training-set/registered_labels/06/bspline -tp training-set/registered_images/06/bspline/TransformParameters.0.txt 

---------------------------

elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1007.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/07/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/07/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/07/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/07/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/07/bspline

transformix -in training-set/training-labels/1007_3C.nii -out training-set/registered_labels/07/rigid -tp training-set/registered_images/07/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/07/rigid/result.nii.gz -out training-set/registered_labels/07/affine -tp training-set/registered_images/07/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/07/affine/result.nii.gz -out training-set/registered_labels/07/bspline -tp training-set/registered_images/07/bspline/TransformParameters.0.txt 

---------------------------
elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1008.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/08/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/08/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/08/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/08/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/08/bspline

transformix -in training-set/training-labels/1008_3C.nii -out training-set/registered_labels/08/rigid -tp training-set/registered_images/08/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/08/rigid/result.nii.gz -out training-set/registered_labels/08/affine -tp training-set/registered_images/08/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/08/affine/result.nii.gz -out training-set/registered_labels/08/bspline -tp training-set/registered_images/08/bspline/TransformParameters.0.txt 
---------------------------
elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1009.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/09/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/09/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/09/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/09/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/09/bspline

transformix -in training-set/training-labels/1009_3C.nii -out training-set/registered_labels/09/rigid -tp training-set/registered_images/09/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/09/rigid/result.nii.gz -out training-set/registered_labels/09/affine -tp training-set/registered_images/09/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/09/affine/result.nii.gz -out training-set/registered_labels/09/bspline -tp training-set/registered_images/09/bspline/TransformParameters.0.txt 


---------------------------
elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1010.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/10/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/10/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/10/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/10/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/10/bspline

transformix -in training-set/training-labels/1010_3C.nii -out training-set/registered_labels/10/rigid -tp training-set/registered_images/10/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/10/rigid/result.nii.gz -out training-set/registered_labels/10/affine -tp training-set/registered_images/10/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/10/affine/result.nii.gz -out training-set/registered_labels/10/bspline -tp training-set/registered_images/10/bspline/TransformParameters.0.txt 

elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1011.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/11/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/11/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/11/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/11/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/11/bspline

transformix -in training-set/training-labels/1011_3C.nii -out training-set/registered_labels/11/rigid -tp training-set/registered_images/11/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/11/rigid/result.nii.gz -out training-set/registered_labels/11/affine -tp training-set/registered_images/11/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/11/affine/result.nii.gz -out training-set/registered_labels/11/bspline -tp training-set/registered_images/11/bspline/TransformParameters.0.txt 


---------------------------
elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1012.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/12/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/12/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/12/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/12/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/12/bspline

transformix -in training-set/training-labels/1012_3C.nii -out training-set/registered_labels/12/rigid -tp training-set/registered_images/12/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/12/rigid/result.nii.gz -out training-set/registered_labels/12/affine -tp training-set/registered_images/12/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/12/affine/result.nii.gz -out training-set/registered_labels/12/bspline -tp training-set/registered_images/12/bspline/TransformParameters.0.txt 



elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1013.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/13/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/13/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/13/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/13/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/13/bspline

transformix -in training-set/training-labels/1013_3C.nii -out training-set/registered_labels/13/rigid -tp training-set/registered_images/13/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/13/rigid/result.nii.gz -out training-set/registered_labels/13/affine -tp training-set/registered_images/13/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/13/affine/result.nii.gz -out training-set/registered_labels/13/bspline -tp training-set/registered_images/13/bspline/TransformParameters.0.txt 

---------------------------
elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1014.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/14/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/14/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/14/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/14/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/14/bspline

transformix -in training-set/training-labels/1014_3C.nii -out training-set/registered_labels/14/rigid -tp training-set/registered_images/14/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/14/rigid/result.nii.gz -out training-set/registered_labels/14/affine -tp training-set/registered_images/14/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/14/affine/result.nii.gz -out training-set/registered_labels/14/bspline -tp training-set/registered_images/14/bspline/TransformParameters.0.txt 




elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1015.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/15/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/15/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/15/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/15/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/15/bspline

transformix -in training-set/training-labels/1015_3C.nii -out training-set/registered_labels/15/rigid -tp training-set/registered_images/15/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/15/rigid/result.nii.gz -out training-set/registered_labels/15/affine -tp training-set/registered_images/15/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/15/affine/result.nii.gz -out training-set/registered_labels/15/bspline -tp training-set/registered_images/15/bspline/TransformParameters.0.txt 

---------------------------
elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1017.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/17/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/17/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/17/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/17/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/17/bspline

transformix -in training-set/training-labels/1017_3C.nii -out training-set/registered_labels/17/rigid -tp training-set/registered_images/17/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/17/rigid/result.nii.gz -out training-set/registered_labels/17/affine -tp training-set/registered_images/17/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/17/affine/result.nii.gz -out training-set/registered_labels/17/bspline -tp training-set/registered_images/17/bspline/TransformParameters.0.txt 



elastix -f training-set/training-images/1000.nii.gz -m training-set/training-images/1036.nii.gz -p Par0026/Par0026rigid.txt -out training-set/registered_images/36/rigid
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/36/rigid/result.0.nii.gz -p Par0026/Par0026affine.txt -out training-set/registered_images/36/affine
elastix -f training-set/training-images/1000.nii.gz -m training-set/registered_images/36/affine/result.0.nii.gz -p Par0026/Par0026bspline.txt -out training-set/registered_images/36/bspline

transformix -in training-set/training-labels/1036_3C.nii -out training-set/registered_labels/36/rigid -tp training-set/registered_images/36/rigid/TransformParameters.0.txt 
transformix -in training-set/registered_labels/36/rigid/result.nii.gz -out training-set/registered_labels/36/affine -tp training-set/registered_images/36/affine/TransformParameters.0.txt 
transformix -in training-set/registered_labels/36/affine/result.nii.gz -out training-set/registered_labels/36/bspline -tp training-set/registered_images/36/bspline/TransformParameters.0.txt 
------------------------------------------
