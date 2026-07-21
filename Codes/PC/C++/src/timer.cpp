#include "timer.h"

// Timer variables
// Based in: https://stackoverflow.com/questions/997946/how-to-get-current-time-and-date-in-c
auto startCountingTimer1 = std::chrono::high_resolution_clock::now();
auto startCountingTimer2 = std::chrono::high_resolution_clock::now();
auto startCountingTimer3 = std::chrono::high_resolution_clock::now();
auto startCountingTimer4 = std::chrono::high_resolution_clock::now();
auto startCountingTimerGyro = std::chrono::high_resolution_clock::now();
auto endCountingTimer1 = std::chrono::high_resolution_clock::now();
auto endCountingTimer2 = std::chrono::high_resolution_clock::now();
auto endCountingTimer3 = std::chrono::high_resolution_clock::now();
auto endCountingTimer4 = std::chrono::high_resolution_clock::now();
auto endCountingTimerGyro = std::chrono::high_resolution_clock::now();

void myDelaySec(int delay) {
	auto start = std::chrono::high_resolution_clock::now();
	auto targetTime = start + std::chrono::seconds(delay);
	while (std::chrono::high_resolution_clock::now() < targetTime) {
		// Do nothing
	}
}

void myDelayMs(int delay) {
	auto start = std::chrono::high_resolution_clock::now();
	auto targetTime = start + std::chrono::milliseconds(delay);
	while (std::chrono::high_resolution_clock::now() < targetTime) {
		// Do nothing
	}
}

void myDelayUs(int delay) {
	auto start = std::chrono::high_resolution_clock::now();
	auto targetTime = start + std::chrono::microseconds(delay);
	while (std::chrono::high_resolution_clock::now() < targetTime) {
		// Do nothing
	}
}

void startTimer1()
{
	startCountingTimer1 = std::chrono::high_resolution_clock::now();
}

void startTimer2()
{
	startCountingTimer2 = std::chrono::high_resolution_clock::now();
}

void startTimer3()
{
	startCountingTimer3 = std::chrono::high_resolution_clock::now();
}

void startTimer4()
{
	startCountingTimer4 = std::chrono::high_resolution_clock::now();
}

void startTimerGyro()
{
	startCountingTimerGyro = std::chrono::high_resolution_clock::now();
}

double getTimeTimer1()
{
	endCountingTimer1 = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> elapsedTime = endCountingTimer1 - startCountingTimer1;
	return elapsedTime.count();
}

double getTimeTimer2()
{
	endCountingTimer2 = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> elapsedTime = endCountingTimer2 - startCountingTimer2;
	return elapsedTime.count();
}

double getTimeTimer3()
{
	endCountingTimer3 = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> elapsedTime = endCountingTimer3 - startCountingTimer3;
	return elapsedTime.count();
}

double getTimeTimer4()
{
	endCountingTimer4 = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> elapsedTime = endCountingTimer4 - startCountingTimer4;
	return elapsedTime.count();
}

double getTimeTimerGyro()
{
	endCountingTimerGyro = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> elapsedTime = endCountingTimerGyro - startCountingTimerGyro;
	return elapsedTime.count();
}