document.addEventListener('DOMContentLoaded', function() {
    const btn = document.getElementById('descubra-btn');
    if (btn) {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.getElementById('valores');
            if (target) {
                target.scrollIntoView({ behavior: 'smooth' });
                target.classList.add('reveal-info');
                setTimeout(() => target.classList.remove('reveal-info'), 1200);
            }
        });
    }
});