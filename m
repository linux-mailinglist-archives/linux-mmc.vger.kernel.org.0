Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C9362E78E
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Nov 2022 23:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241179AbiKQWA4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Nov 2022 17:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiKQWAk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2022 17:00:40 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2689884301
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2022 13:59:07 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 136so3331692pga.1
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2022 13:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5js234S10qtjTG5ViD8Z5NsYYM8xXfh9lDGiYeYzTNk=;
        b=FgMUyRzC1HQVet+tDCWA8ljDeGrHXk7NWmfvGzfwmovUinDK9knhVBWqOEaxR/WKhH
         wwHz/N4KP6pHF44qAgHaZHzh9z++AStihN6Ao5uRAf+yYgVBMZnVIZpD5gjuBWFIjThJ
         QsnQdQgUO9c1DQGCG/8tbnX/sYDH6HkHB7Fks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5js234S10qtjTG5ViD8Z5NsYYM8xXfh9lDGiYeYzTNk=;
        b=zEJopO8zY6tY3zVqLZmfxcW1eei7yxHTG1v6ReKx/fI0TmQJBmxYOOOnxSHapEGFS7
         u/nCUeXRCht4m774qkY4rsZKS4lgjjMypzyEcV+IlAhN+LnHgiG7uELl7sCs6kD+jzdG
         VBaOqgDIZ+ynpO+Z5W2BXExUWUGYRQmecuC/wm/x8DqNBsa6YkswaKawzeGai350e02T
         tUa4xVqYyPpnz8GSs1KVLvK6cJVW3PsVqImviDKt4Rc0pKVzobnQN/pdgfg3T6P8JOu/
         mDf+aF4EurGGpWzK4QRGtL4EWqz7zODwh6va3s1G2tkjdzS2wKnlmiMJO8t/CvdkJIVS
         /cdw==
X-Gm-Message-State: ANoB5pmqOMtUZ0qj6nA58Mm9ZBB4K8FF6T7gl9aKBE2GQLwRcLSj6MNy
        DNAhitqS3/3ieeloU91/pWanaHHw8MCUOQ==
X-Google-Smtp-Source: AA0mqf7QpiIvhVAGN52Mpwqa6vfs4EXQo0/q1js7mM6/xkzmq3rihpfcQy2O/U405oXjhY2LdIG4eg==
X-Received: by 2002:a63:f00d:0:b0:458:f364:b00e with SMTP id k13-20020a63f00d000000b00458f364b00emr3876253pgh.577.1668722346647;
        Thu, 17 Nov 2022 13:59:06 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090341c500b00188fce6e8absm156864ple.280.2022.11.17.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:59:06 -0800 (PST)
Date:   Thu, 17 Nov 2022 13:59:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Darrick J . Wong" <djwong@kernel.org>,
        SeongJae Park <sj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, linux-parisc@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/3] treewide: use get_random_u32_below() instead of
 deprecated function
Message-ID: <202211171359.412AEEE0@keescook>
References: <20221114164558.1180362-1-Jason@zx2c4.com>
 <20221117202906.2312482-1-Jason@zx2c4.com>
 <20221117202906.2312482-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117202906.2312482-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 17, 2022 at 09:29:04PM +0100, Jason A. Donenfeld wrote:
> This is a simple mechanical transformation done by:
> 
> @@
> expression E;
> @@
> - prandom_u32_max
> + get_random_u32_below
>   (E)
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Darrick J. Wong <djwong@kernel.org> # for xfs
> Reviewed-by: SeongJae Park <sj@kernel.org> # for damon
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com> # for infiniband
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk> # for arm
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # for mmc
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
