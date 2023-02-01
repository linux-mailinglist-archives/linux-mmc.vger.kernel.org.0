Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ABD682DA5
	for <lists+linux-mmc@lfdr.de>; Tue, 31 Jan 2023 14:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjAaNVX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 31 Jan 2023 08:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjAaNVO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2023 08:21:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902184FC0E;
        Tue, 31 Jan 2023 05:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aChYpkLRTepXPhbwVpr5jpJ860S0Hxfs+ASMIVu3FYo=; b=XGFfgA23vhXcqVKBotTVxkPEAX
        nVGKM3lWRsLvWqCTlai9GfFhPkYy/xx+fP7z1cQV/laX75Dr4c6VQYtx9Sm8ZtaZIfY/HTsnyZU9N
        Ab88F13MPRyCpKBsBQv/QHIGMzZR/2QaCDHnErViV5x61JBYJhAWuHOhS/cVjv7nwkk+ngTVN0Hzd
        Q+JQOaaT8Mg91vzYCMWfRXYtk325Exh/7ZKhVskh2aAOYwOWJj8qqmNqgcCpscYRyDX6W9wIeWVoJ
        FOhgjdpp6HWE1p2yBXw7of4p4JoBp+Q/kYrm5gwhFuUvUgzJdn8hJ871A2bWdk5LXitPBeeflPHXN
        ERap8gKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMqZ5-0083Wy-04; Tue, 31 Jan 2023 13:20:47 +0000
Date:   Tue, 31 Jan 2023 05:20:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] mmc: core: Imply IOSCHED_BFQ
Message-ID: <Y9kVrh9VEz4/T76f@infradead.org>
References: <20230131084742.1038135-1-linus.walleij@linaro.org>
 <Y9jY2zsNbSCWluZG@infradead.org>
 <CACRpkda3mk8wkdxWQFev9PrK6bPsxR6qLJo_gXnK+_jaTCFfjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkda3mk8wkdxWQFev9PrK6bPsxR6qLJo_gXnK+_jaTCFfjg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 31, 2023 at 10:57:38AM +0100, Linus Walleij wrote:
> Now it doesn't require it, it will just perform better, so thus I use
> 
> imply IOSCHED_BFQ
> 
> the point with it is to help users make the right decisions, not
> enforce them. fs/crypto/Kconfig does the same thing for example,
> advice not enforce.

I'd really love to see how it always works better, as none of that
has actually been documented.  And given the wide variety of hardware
and workloads I also very much doubt it.
