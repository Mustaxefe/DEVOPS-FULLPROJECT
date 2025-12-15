const express = require("express");
const app = express();

const PORT = process.env.PORT || 3000;

let requestCount = 0;
app.use((req, res, next) => {
        requestCount++;
        next();
});

//Função para logar em JSON
function logEvent(route, status, duration) {
	console.log(JSON.stringify({
		route,
		status,
		duration_ms: duration,
		timestamp: new Date().toISOString()
	}));
}

// Rota health (Rápida)
app.get("/health", (req, res) => {
	logEvent("/health", 200, 1);
	res.status(200).json({ status: "OK" });
});

// Rota rápida
app.get("/fast", (req, res) => {
	const start = Date.now();

	const duration = Date.now() - start;
	logEvent("/fast", 200, duration);

	res.json({message: "Fast Response" });
});

//Rota lenta
app.get("/slow", async (req, res) => {
	const start = Date.now();

	await new Promise(resolve => setTimeout(resolve,800)); //0.8s

	const duration = Date.now() - start;
	logEvent("/slow", 200, duration);

	res.json({ message: "Slow response", duration_ms: duration });
});

//Rota que exige CPU
app.get("/cpu", (req, res) => {
	const start = Date.now();

	//Cálculo que irá exigir da CPU
	function nPrimos(num) {
		for (let i = 2; i <= Math.sqrt(num); i++) {
			if (num % i === 0) return false;
		}
		return num > 1;
	}

	let count = 0;
	for (let i = 1; i <= 40000; i++) {
		if(nPrimos(i)) count++;
	}

	const duration = Date.now() - start;

	logEvent("/cpu", 200, duration);

	res.json({ primos_encontrados: count, duration_ms: duration });
});

// Rota que gera erros
app.get("/error", (req, res) => {
	const start = Date.now();

	const shouldFail = Math.random() < 0.2; //20% dos casos

	if (shouldFail) {
		const duration = Date.now() - start;
		logEvent("/error", 500, duration);
		return res.status(500).json({ error: "Interrnal error simulated" });
	}

	const duration = Date.now() - start;
	logEvent("/error", 200, duration);

	res.json({ message: "OK" });
});

//Rota de métricas para o Prometheus
app.get("/metrics", (req, res) => {
	res.set("Content-Type", "text/plain");
	res.send(`
	# HELP api_requests_total Total de requisições
	# TYPE api_requests_total counter
	api_requests_total ${requestCount}
	`);
});

app.listen(PORT, () => {
	console.log(`API running on port ${PORT}`);
});
