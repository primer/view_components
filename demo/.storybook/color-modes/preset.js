function managerEntries(entry = [], options) {
  return [...entry, require.resolve('./register')];
}

module.exports = {
  managerEntries,
};
