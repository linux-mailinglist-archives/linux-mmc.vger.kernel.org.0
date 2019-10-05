Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD50CC733
	for <lists+linux-mmc@lfdr.de>; Sat,  5 Oct 2019 03:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfJEB0Q (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 4 Oct 2019 21:26:16 -0400
Received: from void.printf.net ([40.143.112.133]:41852 "EHLO void.printf.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJEB0P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 4 Oct 2019 21:26:15 -0400
X-Greylist: delayed 1946 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2019 21:26:15 EDT
Received: from chris by void.printf.net with local (Exim 4.69)
        (envelope-from <chris@void.printf.net>)
        id 1iGYKQ-0006M2-FK; Sat, 05 Oct 2019 01:53:46 +0100
Date:   Sat, 5 Oct 2019 01:53:46 +0100
From:   Chris Ball <chris@printf.net>
To:     Michael Heimpold <mhei@heimpold.de>
Cc:     linux-mmc@vger.kernel.org
Subject: Re: [PATCH mmc-utils v2 0/5] Various fixes for mmc-utils
Message-ID: <20191005005346.GA24379@void.printf.net>
References: <20190912210509.19816-1-mhei@heimpold.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912210509.19816-1-mhei@heimpold.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Michael,

On Thu, Sep 12, 2019 at 11:05:04PM +0200, Michael Heimpold wrote:
> This series bundles several small fixes and enhancements
> I stumbled over during short testing around one year ago.
> 
> The initial sent v1 got a review by Avri, but was not applied (yet).
> 
> I'm resending this v2 with the hope, that there is now some
> more interest.
> 
> I added his Reviewed-by, no other technical changes.
> 
> It can also be found in my Github tree:
> https://github.com/mhei/mmc-utils/tree/fixes-enh
> 
> Michael Heimpold (5):
>   Check calloc's return value before using the pointer
>   Cleanup memory in error case
>   Fix parsing of character in to_binstr()
>   Optimize to_binstr() function
>   Add eMMC vendor Micron to table

Thanks, pushed to mmc-next master, apologies for the delay.

- Chris.
-- 
Chris Ball   <http://printf.net/>
