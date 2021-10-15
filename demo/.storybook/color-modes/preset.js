function managerEntries(entry = []) {
  return [...entry, require.resolve('./register')];
}

module.exports = {
  managerEntries,
};
