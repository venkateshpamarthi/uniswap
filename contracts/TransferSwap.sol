// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.17;
pragma abicoder v2;

import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';
import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';
import '@uniswap/v3-periphery/contracts/interfaces/IQuoter.sol';


contract TransferSwap {
    
    address  constant routerAddress = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
    ISwapRouter public immutable swapRouter = ISwapRouter(routerAddress);
    IQuoter public constant quoter = IQuoter(0xb27308f9F90D607463bb33eA1BeBb41C27CE5AB6);
    
   //token addresses to swap
    address public constant puni =  0x1a0bb9499D633B36a1d88F3F3Da763d276f903B6;
    address public constant vky = 0xA673a9cc54466Dc36Be3cadB1EfD1b3BfC716BFE;
     
    uint24 public constant poolFee = 10000;

    function getEstimated(uint _tokenInAmount) external returns (uint256) {
     address tokenIn = puni;
     address tokenOut = vky;
     uint24 fee = poolFee;
     uint160 sqrtPriceLimitX96 = 0;

     return quoter.quoteExactInputSingle(
         tokenIn,
         tokenOut,
         fee,
         _tokenInAmount,
         sqrtPriceLimitX96
      );
    }

   
   
    function swapExactInputSingle(uint256 amountIn) external returns (uint256 amountOut) {
       
        TransferHelper.safeTransferFrom(puni, msg.sender, address(this), amountIn);

        
        TransferHelper.safeApprove(puni, address(swapRouter), amountIn);

       
        ISwapRouter.ExactInputSingleParams memory params =
            ISwapRouter.ExactInputSingleParams({
                tokenIn: puni,
                tokenOut: vky,
                fee: poolFee,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        // The call to `exactInputSingle` executes the swap.
        amountOut = swapRouter.exactInputSingle(params);
    }
}