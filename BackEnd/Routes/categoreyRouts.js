const express = require('express');
const { getItemsByCategory,listCategories} =require('../Controllers/CategoryController');
const router=express.Router();
router.route('/:categoryId').get(getItemsByCategory);
router.route('/').get(listCategories);

module.exports=router;