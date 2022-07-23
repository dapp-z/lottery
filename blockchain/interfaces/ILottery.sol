// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title The interface for the lottery contract
interface ILottery {
    /// @notice Refers to lottery status
    enum Status {
        NOT_STARTED, // The lottery is not started yet
        OPEN, // The lottery is open for ticket purchases
        CLOSED, // The lottery is no longer open for ticket purchases
        COMPLETED // The lottery has been closed and the winner picked
    }

    /// @notice Emitted when the prize is claimed
    /// @param lotteryId The ID of the lottery
    event ClaimedReward(uint256 lotteryId);

    /// @notice Emitted when the lottery is closed
    /// @param lotteryId The ID of the lottery
    event ClosedLottery(uint256 lotteryId);

    /// @notice Emitted when the lottery is completed
    /// @param lotteryId The ID of the lottery
    event CompletedLottery(uint256 lotteryId);

    /// @notice Emitted when a lottery is started
    /// @param lotteryId The ID of the lottery
    event OpenedLottery(uint256 lotteryId);

    /// @notice Emitted when a random number is requested
    /// @param requestId The ID of the random number request
    event RequestedRandomWords(uint256 requestId);

    /// @return The current lottery id
    function lotteryID() external view returns (uint256);

    /// @return The participant address of the given index of the current lottery
    function participants(uint256) external view returns (address);

    /// @return The ticket price of the current lottery
    function costPerTicket() external view returns (uint256);

    /// @return The prize pot of the current lottery
    function prizePool() external view returns (uint256);

    /// @return The start time of the current lottery
    function startingTimestamp() external view returns (uint256);

    /// @return The winner of the current lottery
    function winner() external view returns (address);

    /// @return The random number generated by chainlink for the current lottery
    function randomResult() external view returns (uint256);

    /// @return The duration of the current lottery
    function lotteryDuration() external view returns (uint256);

    /// @return The percentage amount awarded to the winner in the current lottery
    function winnerPercentage() external view returns (uint8);

    /// @return The current lottery status
    function lotteryStatus() external view returns (Status);

    /// @notice Stores all information of all lotteries
    /// @return The lottery information for the given index
    function allLotteries(uint256)
        external
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256,
            address,
            uint256
        );

    /// @notice Starts a lottery
    /// @param _ticketPrice Current lottery ticket price
    /// @param _winnerPercentage The percentage amount awarded to the winner
    /// @param _lotteryDuration The duration of the lottery after which no more tickets
    /// will be sold for the lottery.
    function startLottery(
        uint256 _ticketPrice,
        uint8 _winnerPercentage,
        uint256 _lotteryDuration
    ) external;

    /// @notice Buys a ticket for the sender of the transaction
    function buyTicket() external payable;

    /// @notice Closes the current lottery
    function closeLottery() external;

    /// @notice Sends the prize of the closed lottery to the winner
    function claimReward() external;

    /// @notice Sends the rest of the prize pots to the owner
    function withdrawEth() external;
}
