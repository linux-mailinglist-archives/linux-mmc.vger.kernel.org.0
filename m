Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30A475964
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Jul 2019 23:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGYVPy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Jul 2019 17:15:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39457 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfGYVPy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Jul 2019 17:15:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so49333872ljh.6
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jul 2019 14:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QyLM8RB2yBsbcM/r46DBJ/7whgdS3GFmfjZtohkegB0=;
        b=1b2ENCJMmx829ayIvnGsflHQEYSLMCuC+K3Vx4qNMh8rNBFEd+ywfoK93VhQ0qWDLZ
         S0bDAeS6ni3Y9umjss5gsgrfJAMETM8oLnV1sMHRiCzL6jBbgWXUyHMl9tdPCi99Vl/5
         sEa0ozA96STFuX5wus/DA4odpegHrgUY9f6H/F4Fh3Cas0Y1hb9ETezEZ52bKmhzRRWe
         MJNUuEc8wt94FaN1uQL/fBKn+Fu5AUUxTudten+EX7vmnRixpyxvGvB93+yLnMYU1nUR
         AEc0bH+BpXUsyms4BHNc+7DJvvp9/jIVeasoSZcCwwch67is1zOX5yEHEgnpkMXbNBk9
         y4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QyLM8RB2yBsbcM/r46DBJ/7whgdS3GFmfjZtohkegB0=;
        b=lvbAmy0ORf9KTqIolsioxrhs/tK25WOcEmFW5uPcUaZMoNgHiQttpGicgyDaGDNRRT
         wwGnx/NaJwCA+71xmkRJiv1OnbYfJTqqVXHns738OSb534SA0LPt9nzVzYK5+tVqN25L
         iLJOmleZcI+uscs+qgK9hiVzJOyn8PyxAqUbV7QgAoV33RBTdvFIG7JRoCuwuIJpcLju
         o9np9wVCG9uA7B0gnBdg7JE9vD0oG+xoQzPBNxbUpUGoEPo46q9dPxyoR24wCEGQSx4q
         sAZpOQne9svjUYpk/IIlJQp9kk99AFMM/qezj0CvKy2jnT0VwRiEp+APd/TmBuRjoHKT
         sDLw==
X-Gm-Message-State: APjAAAWdlNzBSiFMxoWKh7e4LNfzF3UczlyEdwqxSv93JYI/lilxt/zd
        biYHm/DEKXtmNXM3k+wIYx8=
X-Google-Smtp-Source: APXvYqw/qSZwDOkkTn5AE4Vj8wGeORBjYwVg88VRLrYVQs7eIq9S8uQ4WyyFLxymOkzF873eVMCcbw==
X-Received: by 2002:a2e:9b48:: with SMTP id o8mr47614971ljj.122.1564089352205;
        Thu, 25 Jul 2019 14:15:52 -0700 (PDT)
Received: from localhost (customer-145-14-112-32.stosn.net. [145.14.112.32])
        by smtp.gmail.com with ESMTPSA id k12sm7773389lfc.8.2019.07.25.14.15.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 14:15:51 -0700 (PDT)
Date:   Thu, 25 Jul 2019 23:15:51 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Ulrich Hecht <uli+renesas@fpond.eu>
Cc:     linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        wsa@the-dreams.de, yamada.masahiro@socionext.com,
        geert@linux-m68k.org, ulf.hansson@linaro.org, magnus.damm@gmail.com
Subject: Re: [PATCH 0/2] mmc: tmio: remove Gen2+ workaround and fix up
Message-ID: <20190725211551.GJ19108@bigcity.dyn.berto.se>
References: <1563289264-26432-1-git-send-email-uli+renesas@fpond.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1563289264-26432-1-git-send-email-uli+renesas@fpond.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulrich,

Thanks for your work.

On 2019-07-16 17:01:02 +0200, Ulrich Hecht wrote:
> Hi!
> 
> The second patch in this series removes a workaround that forced eMMC devices
> always on and that is no longer required.
> 
> Removing it does expose a bug, however, that leads to a clock imbalance due
> to the clock being enabled by both PM and the hardware driver. (See
> https://www.spinics.net/lists/linux-mmc/msg54009.html for discussion.)
> This bug is taken care of by the first patch.
> 
> Tested on r8a7790 (Lager), r8a7795 and r8a7796 (Salvator-X) with SD and
> eMMC, before and after suspend.
> 
> CU
> Uli
> 
> 
> Ulrich Hecht (2):
>   mmc: tmio: leave clock handling to PM if enabled
>   mmc: tmio: remove obsolete PM workaround

Tested-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

> 
>  drivers/mmc/host/tmio_mmc_core.c | 33 ++++++---------------------------
>  1 file changed, 6 insertions(+), 27 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
