/* Favorite page interactions: search filter, expand/collapse all, highlight */
(function () {
  const root = document.getElementById('favorite');
  if (!root) return;

  const searchInput = root.querySelector('#fav-search');
  const cards = Array.from(root.querySelectorAll('.fav-card'));
  const empty = root.querySelector('.fav-empty');
  const backTop = root.querySelector('#back-to-top');

  // Persist details open state
  const STORE_KEY = 'favorite:open-state';
  function loadState() {
    try { return JSON.parse(localStorage.getItem(STORE_KEY) || '{}'); } catch { return {}; }
  }
  function saveState(state) {
    try { localStorage.setItem(STORE_KEY, JSON.stringify(state)); } catch (e) {}
  }
  function applySavedOpenState() {
    const state = loadState();
    cards.forEach(card => {
      const id = card.id || '';
      const v = state[id];
      if (v === true) card.setAttribute('open', 'open');
      else if (v === false) card.removeAttribute('open');
      // if undefined, keep default (currently open by default)
    });
  }
  applySavedOpenState();

  // Keep default layout (sidebar visible). Page width tuning handled via CSS.

  function normalize(s) { return (s || '').toLowerCase(); }

  function clearHighlights(el) {
    el.querySelectorAll('mark[data-fav]')
      .forEach(m => m.replaceWith(document.createTextNode(m.textContent)));
  }

  function highlightText(node, query) {
    if (!query) return;
    const text = node.textContent;
    const idx = text.toLowerCase().indexOf(query.toLowerCase());
    if (idx === -1) return;
    const before = document.createTextNode(text.slice(0, idx));
    const mark = document.createElement('mark');
    mark.setAttribute('data-fav', '');
    mark.textContent = text.slice(idx, idx + query.length);
    const after = document.createTextNode(text.slice(idx + query.length));
    node.replaceChildren(before, mark, after);
  }

  function applyFilter(q) {
    const query = normalize(q);
    let visibleCount = 0;
    cards.forEach(card => {
      // Reset highlights
      clearHighlights(card);
      const titleEl = card.querySelector('.fav-title');
      const links = Array.from(card.querySelectorAll('.fav-links a'));
      const title = normalize(titleEl.textContent);
      let match = title.includes(query);

      let anyLinkMatch = false;
      links.forEach(a => {
        const text = normalize(a.textContent);
        const isMatch = !query || text.includes(query);
        a.parentElement.style.display = isMatch ? '' : 'none';
        anyLinkMatch = anyLinkMatch || isMatch;
      });

      // Card visibility
      const show = !query || match || anyLinkMatch;
      card.style.display = show ? '' : 'none';
      if (show) {
        visibleCount++;
        // Expand if filtering and found a match
        if (query) card.setAttribute('open', 'open');
        if (query && match) highlightText(titleEl, q);
        if (query) {
          links.forEach(a => { if (a.parentElement.style.display !== 'none') highlightText(a, q); });
        }
      }
    });
    if (empty) empty.hidden = visibleCount > 0;
  }

  // Search input handler
  if (searchInput) {
    searchInput.addEventListener('input', (e) => applyFilter(e.target.value));
  }

  // Expand/collapse all
  root.addEventListener('click', (e) => {
    const btn = e.target.closest('[data-action]');
    if (!btn) return;
    const action = btn.getAttribute('data-action');
    const state = loadState();
    if (action === 'expand') cards.forEach(c => { c.setAttribute('open', 'open'); state[c.id] = true; });
    if (action === 'collapse') cards.forEach(c => { c.removeAttribute('open'); state[c.id] = false; });
    saveState(state);
  });

  // Save per-section toggle
  cards.forEach(card => {
    card.addEventListener('toggle', () => {
      const state = loadState();
      state[card.id] = card.open;
      saveState(state);
    });
  });

  // Back-to-top
  if (backTop) {
    window.addEventListener('scroll', () => {
      if (window.scrollY > 400) backTop.classList.add('show');
      else backTop.classList.remove('show');
    }, { passive: true });
    backTop.addEventListener('click', () => window.scrollTo({ top: 0, behavior: 'smooth' }));
  }
})();
