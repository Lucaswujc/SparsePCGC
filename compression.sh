export DEVICE="cpu"
#!/bin/bash

export DATA_ROOT=$HOME/repos/SparsePCGC/data
export CKPTS=${DATA_ROOT}/ckpts
export REPO_ROOT=$HOME/repos/SparsePCGC
export TEST_ROOT=${REPO_ROOT}/test
export KITTI_TEST=${REPO_ROOT}/kitti/training/velodyne_reduced_test

### Lossless compression
python ${TEST_ROOT}/test_ours_sparse.py --mode='lossless' \
  --ckptdir_low="${CKPTS}/sparse_low/epoch_last.pth" \
  --ckptdir_high="${CKPTS}/sparse_high/epoch_last.pth" \
  --filedir="${KITTI_TEST}" \
  --voxel_size=0.02 \
  --outdir="${REPO_ROOT}/results/our_results" \
  --resultdir="${REPO_ROOT}/results" \
  --prefix="sparse_results_lossless" \
  --device="${DEVICE}"


# ### Lossy compression (gpcc)
# python ${TEST_ROOT}/test_ours_sparse.py --mode='lossy' \
#   --ckptdir_low="${CKPTS}/sparse_low/epoch_last.pth" \
#   --ckptdir_high="${CKPTS}/sparse_high/epoch_last.pth" \
#   --filedir="${KITTI_TEST}" \
#   --voxel_size=0.02 \
#   --outdir="${REPO_ROOT}/results/our_results" \
#   --resultdir="${REPO_ROOT}/results" \
#   --prefix="sparse_results_lossy_gpcc" \
#   --device="cpu"


### Dense lossless compression
python ${TEST_ROOT}/test_ours_dense.py --mode='lossless' \
  --ckptdir="${CKPTS}/dense/epoch_last.pth" \
  --filedir="${KITTI_TEST}" \
  --voxel_size=0.02 \
  --outdir="${REPO_ROOT}/results/our_results" \
  --resultdir="${REPO_ROOT}/results" \
  --prefix="dense_results_lossless" \
  --device="${DEVICE}"


### Dense lossy compression
python ${TEST_ROOT}/test_ours_dense.py --mode='lossy' \
  --ckptdir="${CKPTS}/dense/epoch_last.pth" \
  --ckptdir_sr="${CKPTS}/dense_1stage/epoch_last.pth" \
  --ckptdir_ae="${CKPTS}/dense_slne/epoch_last.pth" \
  --filedir="${KITTI_TEST}" \
  --psnr_resolution=1023 \
  --voxel_size=0.02 \
  --outdir="${REPO_ROOT}/results/our_results" \
  --resultdir="${REPO_ROOT}/results" \
  --prefix="dense_results_lossy" \
  --device="${DEVICE}"