{.emit"""
#include <Eigen/SparseCore>
typedef Eigen::SparseMatrix<std::complex<double>,Eigen::ColMajor> SparseMatrixXcdC;
typedef Eigen::SparseMatrix<std::complex<float>,Eigen::ColMajor> SparseMatrixXcfC;
typedef Eigen::SparseMatrix<double,Eigen::ColMajor> SparseMatrixXdC;
typedef Eigen::SparseMatrix<float,Eigen::ColMajor> SparseMatrixXfC;
typedef Eigen::SparseMatrix<std::complex<double>,Eigen::RowMajor> SparseMatrixXcdR;
typedef Eigen::SparseMatrix<std::complex<float>,Eigen::RowMajor> SparseMatrixXcfR;
typedef Eigen::SparseMatrix<double,Eigen::RowMajor> SparseMatrixXdR;
typedef Eigen::SparseMatrix<float,Eigen::RowMajor> SparseMatrixXfR;
""".}
