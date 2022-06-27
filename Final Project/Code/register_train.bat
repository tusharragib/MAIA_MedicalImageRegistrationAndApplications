

elastix -f train/copd1/copd1_iBHCT.nii -m train/copd1/copd1_eBHCT.nii -fMask train/copd1/copd1_mask_iBHCT.nii -mMask train/copd1/copd1_mask_eBHCT.nii -p Par0009/Parameters.Par0009.affine.txt -p Par0009/Parameters.Par0009.elastic.txt -out registered_inhale/copd1/Par0003/ 
transformix -def train/copd1/copd1_300_iBH_xyz_r1.txt -out registered_inhale/copd1/Par0003/transformix/ -tp registered_inhale/copd1/Par0003/TransformParameters.1.txt


elastix -f train/copd2/copd2_iBHCT.nii -m train/copd2/copd2_eBHCT.nii -fMask train/copd2/copd2_mask_iBHCT.nii -mMask train/copd2/copd2_mask_eBHCT.nii -p Par0009/Parameters.Par0009.affine.txt -p Par0009/Parameters.Par0009.elastic.txt -out registered_inhale/copd2/Par0003/ 
transformix -def train/copd2/copd2_300_iBH_xyz_r1.txt -out registered_inhale/copd2/Par0003/transformix/ -tp registered_inhale/copd2/Par0003/TransformParameters.1.txt

elastix -f train/copd3/copd3_iBHCT.nii -m train/copd3/copd3_eBHCT.nii -fMask train/copd3/copd3_mask_iBHCT.nii -mMask train/copd3/copd3_mask_eBHCT.nii -p Par0009/Parameters.Par0009.affine.txt -p Par0009/Parameters.Par0009.elastic.txt -out registered_inhale/copd3/Par0003/ 
transformix -def train/copd3/copd3_300_iBH_xyz_r1.txt -out registered_inhale/copd3/Par0003/transformix/ -tp registered_inhale/copd3/Par0003/TransformParameters.1.txt


elastix -f train/copd4/copd4_iBHCT.nii -m train/copd4/copd4_eBHCT.nii -fMask train/copd4/copd4_mask_iBHCT.nii -mMask train/copd4/copd4_mask_eBHCT.nii -p Par0009/Parameters.Par0009.affine.txt -p Par0009/Parameters.Par0009.elastic.txt -out registered_inhale/copd4/Par0003/ 
transformix -def train/copd4/copd4_300_iBH_xyz_r1.txt -out registered_inhale/copd4/Par0003/transformix/ -tp registered_inhale/copd4/Par0003/TransformParameters.1.txt


elastix -f train/copd7/copd7_iBHCT.nii -m train/copd7/copd7_eBHCT.nii -fMask train/copd7/copd7_mask_iBHCT.nii -mMask train/copd7/copd7_mask_eBHCT.nii -p Par0003/Par0003.affine.txt -p Par0003/Par0003.bs-R8-ug.txt -out registered_inhale/copd7/Par0003/ 
transformix -def train/copd7/copd7_300_iBH_xyz_r1.txt -out registered_inhale/copd7/Par0003/transformix/ -tp registered_inhale/copd7/Par0003/TransformParameters.1.txt


elastix -f train/copd8/copd8_iBHCT.nii -m train/copd8/copd8_eBHCT.nii -fMask train/copd8/copd8_mask_iBHCT.nii -mMask train/copd8/copd8_mask_eBHCT.nii -p Par0003/Par0003.affine.txt -p Par0003/Par0003.bs-R8-ug.txt -out registered_inhale/copd8/Par0003/ 
transformix -def train/copd8/copd8_300_iBH_xyz_r1.txt -out registered_inhale/copd8/Par0003/transformix/ -tp registered_inhale/copd8/Par0003/TransformParameters.1.txt


elastix -f train/copd9/copd9_iBHCT.nii -m train/copd9/copd9_eBHCT.nii -fMask train/copd9/copd9_mask_iBHCT.nii -mMask train/copd9/copd9_mask_eBHCT.nii -p Par0003/Par0003.affine.txt -p Par0003/Par0003.bs-R8-ug.txt -out registered_inhale/copd9/Par0003/ 
transformix -def train/copd9/copd9_300_iBH_xyz_r1.txt -out registered_inhale/copd9/Par0003/transformix/ -tp registered_inhale/copd9/Par0003/TransformParameters.1.txt

elastix -f train/copd10/copd10_iBHCT.nii -m train/copd10/copd10_eBHCT.nii -fMask train/copd10/copd10_mask_iBHCT.nii -mMask train/copd10/copd10_mask_eBHCT.nii -p Par0003/Par0003.affine.txt -p Par0003/Par0003.bs-R8-ug.txt -out registered_inhale/copd10/Par0003/ 
transformix -def train/copd10/copd10_300_iBH_xyz_r1.txt -out registered_inhale/copd10/Par0003/transformix/ -tp registered_inhale/copd10/Par0003/TransformParameters.1.txt


