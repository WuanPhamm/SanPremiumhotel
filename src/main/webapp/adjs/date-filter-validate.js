    const formSelectors = ['form[action="customer_report"]', 'form[action="booking_report"]', 'form[action="revenue_report"]'];

    formSelectors.forEach(selector => {
        const form = document.querySelector(selector);
        if (form) {
            form.addEventListener('submit', function(e) {
                const startVal = this.s.value.trim();
                const endVal = this.e.value.trim();

                if (!startVal || !endVal) {
                    e.preventDefault();
                    alert("Cả hai trường 'Bắt đầu' và 'Kết thúc' đều phải được nhập.");
                    return;
                }

                const startDate = new Date(startVal);
                const endDate = new Date(endVal);

                if (endDate < startDate) {
                    e.preventDefault();
                    alert("Ngày 'Kết thúc' phải lớn hơn hoặc bằng ngày 'Bắt đầu'.");
                }
            });
        }
    });
