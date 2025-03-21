import numpy as np
class Utilities():
    def refine_masks(masks, rois):
        areas = np.sum(masks.reshape(-1, masks.shape[-1]), axis=0)
        mask_index = np.argsort(areas)
        union_mask = np.zeros(masks.shape[:-1], dtype=bool)
        for m in mask_index:
            masks[:, :, m] = np.logical_and(masks[:, :, m], np.logical_not(union_mask))
            union_mask = np.logical_or(masks[:, :, m], union_mask)
        for m in range(masks.shape[-1]):
            mask_pos = np.where(masks[:, :, m]==True)
            if np.any(mask_pos):
                y1, x1 = np.min(mask_pos, axis=1)
                y2, x2 = np.max(mask_pos, axis=1)
                rois[m, :] = [y1, x1, y2, x2]
        return masks, rois