Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F16B309
	for <lists+linux-mmc@lfdr.de>; Wed, 17 Jul 2019 03:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfGQBNH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 16 Jul 2019 21:13:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37382 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfGQBNH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2019 21:13:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so9958325pfa.4
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jul 2019 18:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DKSAC3RBFj87Z4DA1X5Y/Vpx+6+m2Zkrc246nbB+7aI=;
        b=JoLirFbfMmaohKWvyvur/2xz2kl1DEhYDF03OFkXDrF33zT83ZoU8qaleGSKaP3fcl
         4FrfHCQlUwmbMoO+6KqY+rJU4EV27QrFqL/QiuPvJ1KXVlzDS1sUxZ1xAV3xLuQ86ver
         J8CioVdY/f2zLPeRN9brRwq6ygdez3UPMbsd64geGO4uJDaybiKyAdFAydK4Pk/9zR4k
         f/a+xpRfG/u2NTrftUpWR7R21rLKcYZ4iypaQ3l0aVWtKYyMymR4TIQJvGUu9QjTHVO8
         tqvHUA+WrXusysPEnDpq/i9rI81PyNAbtk7ipxgLlKtCsjgd89ywEfnaQRPWq/0dhbKB
         GbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DKSAC3RBFj87Z4DA1X5Y/Vpx+6+m2Zkrc246nbB+7aI=;
        b=Q/CAElOhkmQJB/6M7+P1wvJBRdk8GUto+YK+SdCMGCTmt/Zl9Vh0XPdsNui0rQxffO
         ijTmquwOMSA1fStZtachDjTI/Jmw7Uh67wvbvSEBbp4lslZHx2XZ5PIAZum41esvQ78l
         xH8rVkF76y657AroEA1eA1ZYJVnbeN01mYt59Nt9Xx2A7s6wafe+snqQnhQcG1kmdGH9
         vOM5MOQR1zfVyIz5/YGACVfwEOxAbPAue0Qe7qy9C8wfnR6irv7ry/ed7Tv8BkWsi23k
         l0XJ7k9CrDzPEo0VXofkRzO3HVDz064h9OoGy1gyZhg9a9Rju1QmDeoZXwnEr4acf879
         N67Q==
X-Gm-Message-State: APjAAAVJPFqOZKw6S8heGXKK0ZyTh63HwjwybEZBiavP/khf8Gc7uMhU
        32ZzyfCWSuSagSk67v9iGmM=
X-Google-Smtp-Source: APXvYqyLDHDQmRz8I2LVJ/zkW9FvFC/OmLcogJhcrjQswuIkVzAwMyMppCgHQxf8hVcf/ipzJG11oA==
X-Received: by 2002:a63:f857:: with SMTP id v23mr12665476pgj.228.1563325985936;
        Tue, 16 Jul 2019 18:13:05 -0700 (PDT)
Received: from localhost (softbank126159215226.bbtec.net. [126.159.215.226])
        by smtp.gmail.com with ESMTPSA id l6sm22170067pga.72.2019.07.16.18.13.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 18:13:04 -0700 (PDT)
Date:   Wed, 17 Jul 2019 10:13:01 +0900
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        yamada.masahiro@socionext.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, magnus.damm@gmail.com
Subject: Re: [PATCH 1/2] mmc: tmio: leave clock handling to PM if enabled
Message-ID: <20190717011301.GG4384@wyvern>
References: <1563289264-26432-1-git-send-email-uli+renesas@fpond.eu>
 <1563289264-26432-2-git-send-email-uli+renesas@fpond.eu>
 <20190716190524.no5d25iyllgjdluh@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190716190524.no5d25iyllgjdluh@katana>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2019-07-16 21:05:24 +0200, Wolfram Sang wrote:
> On Tue, Jul 16, 2019 at 05:01:03PM +0200, Ulrich Hecht wrote:
> > This fixes a clock imbalance that occurs because the SD clock is handled
> > by both PM and the hardware driver.
> > See https://www.spinics.net/lists/linux-mmc/msg44431.html for details.
> > 
> > This patch removes the clock handling from the driver's PM callbacks and
> > turns the clock off after probing.
> > 
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Ulrich Hecht <uli+renesas@fpond.eu>
> 
> Thanks, Uli!
> 
> Niklas, I'd really like your feedback on this one because you did the PM
> refactorization lately.

I would like to test this too. Unfortunately I'm on the road and will be 
back in the office the 23rd so I will have to postpone doing so until 
then. My initial comment is that this looks good, thanks Ulrich.

> 
> I will have a look later, too.
> 



-- 
Regards,
Niklas Söderlund
