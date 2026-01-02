## SQL Query Optimization Summary

### Before Optimization
- Sequential scans observed on multiple queries
- Higher execution cost due to lack of indexing
- Unnecessary NULL scans and late filtering

### After Optimization
- Index scans used on frequently filtered columns
- Reduced execution cost and rows scanned
- Improved query performance through early filtering

### Key Improvements
- Reduced query cost by improving filtering and index usage
- Improved query readability and maintainability
