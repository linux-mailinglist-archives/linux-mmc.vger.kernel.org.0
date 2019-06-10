Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209223B528
	for <lists+linux-mmc@lfdr.de>; Mon, 10 Jun 2019 14:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388394AbfFJMlp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 10 Jun 2019 08:41:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44603 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfFJMlp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2019 08:41:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so7772588ljc.11
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2019 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=m3mx8nSSTHaU+T/0g0tWzbByEX3Al/na/Ho74F2I+24=;
        b=ZEbPO1WpO4GPT6urNEVcQB4po3YwLHpf3Xdz1haVMtxhooK+fb2KsThnNSttEy3K94
         Pp/Qi/RMUcxQIjJOVlKfkA01YEba1IzQgs19Ui6fR6wUWCwJFyKU9lvl/vm/U2Bagqfy
         TMJawaaE51IFYaFmeKrFoB9cURr/NXG9mURubbuRxAZhiIE1NGuoUyWQ8HB51ajGaynO
         DBc5tIy2NStTIFtF4m2uPCO0mK03t7AGx3d6bw1Ombn+JCEJ6wp5hkNhn0u8q8GufxTy
         S4LdVoCLW4z6r3FbQmOUDtP6m2xu3PWhMmLLAitr0XDt+A81KYrE1qTrG5M0IA7Mj9oM
         NLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m3mx8nSSTHaU+T/0g0tWzbByEX3Al/na/Ho74F2I+24=;
        b=ei4cBVqGvksWMtOnYKVdKAg56i9A+ujKFbep5KTAWLOjGR7U10YAm/pLy4vNYno1d/
         5ln90xHGLaXQQNe1dbnAdIxxJzLcc/r3daUqB8fx5pSbUEwBE/X9a7oxRdxTHud64DP3
         mV8v8QLwt5/+SSZFF8iz7g8RWk+clC4Z5IpZQkWinhfMGt3SxnK0B/TB98lcoqJEFCYU
         lELsbnvK7D8RyGR/QCKJdd71IRfUX9+iDqS6VIySpt9Vw2BGh7MGMEqAYKjH9WgqmCQv
         TdNFy87Spl0+RMoY3vDL1TkGkldE8HBpPEzRQpnNXZny8Obblsii47RRsVdHPXvgmq29
         T+RQ==
X-Gm-Message-State: APjAAAUt5S6frSHTSweQrFO8HK2tmxlTAdeWIHaBk5wIXTsqjrDg/vth
        nfUKKoPAjO8jvqjJfLyY5XysJqo9mHc=
X-Google-Smtp-Source: APXvYqzHy5XMjNhRxEh+WT0U5PkyFCNWd9safovASUZtsFoTB90r3sExD1MhxZ+Ls9m/8B+LipWoag==
X-Received: by 2002:a2e:124b:: with SMTP id t72mr27478549lje.143.1560170503715;
        Mon, 10 Jun 2019 05:41:43 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id x20sm1939069ljc.15.2019.06.10.05.41.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 05:41:42 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:41:42 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 0/3] mmc: sdhi: improve HS400 quirk handling
Message-ID: <20190610124142.GC1362@bigcity.dyn.berto.se>
References: <20190604151530.7023-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190604151530.7023-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2019-06-04 17:15:27 +0200, Wolfram Sang wrote:
> There are some more SoCs which cannot handle HS400. Add them and clean up the
> quirk handling a bit. So, patch 1 is suitable for stable, the rest isn't.
> 
> Note that I don't have that HW, so I am relying on the provided information.
> 
> Wolfram Sang (3):
>   mmc: sdhi: disallow HS400 for M3-W ES1.2 and V3H
>   mmc: sdhi: improve quirk descriptions
>   mmc: sdhi: remove unneeded initialization

For the whole series, with or without merging the r8a7796 entries per 
Geert's comments,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
>  drivers/mmc/host/renesas_sdhi_core.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> -- 
> 2.11.0
> 

-- 
Regards,
Niklas Söderlund
