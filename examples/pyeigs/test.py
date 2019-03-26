import numpy as np

import pyeigs

mat = np.array([[1, 2j], [3, 4]])
print("numpy:", np.linalg.eigvals(mat))
print("pyeigs:", pyeigs.eigs(mat).transpose())
