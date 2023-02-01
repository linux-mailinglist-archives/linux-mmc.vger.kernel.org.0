Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AFF68280B
	for <lists+linux-mmc@lfdr.de>; Tue, 31 Jan 2023 10:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjAaJFC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 31 Jan 2023 04:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjAaJEp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2023 04:04:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9158D4F35F;
        Tue, 31 Jan 2023 01:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zCbjOcyGzOWndtcqoe67R24FhbbEYi80tEJLcTYUHz8=; b=IE2HvVp80OWc9Ff7Ji6enEIT18
        fWphPN3EAe5IPsn0H0aVIUCkBDjWNIYA5fs3KHHKHTnCGdSbJiSCFHegx2zeHIlsTxdcYMDPgSgaO
        eBVpYzPCNMvd79GCOTDNt9Zvf2DbsQc+2JYdoE4w+/ZWGttApIPw106fonf/v22443HftEum+2OYj
        UmninENwEMa+4PafuMrb9yTBX9rd2NZAAA98EpcldqBr7QafrV/kihrWdypj4M0GFiKil7PtOoSbO
        +ZVfQa1d6gEKPmGdQU4vM1UZFkA3e9mu0RLit/k2A8jBb6j+ZMeAPNl0Tl2bisCoWRhUhi4PA7F38
        T/Rpr4Uw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMmVv-006t05-7B; Tue, 31 Jan 2023 09:01:15 +0000
Date:   Tue, 31 Jan 2023 01:01:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] mmc: core: Imply IOSCHED_BFQ
Message-ID: <Y9jY2zsNbSCWluZG@infradead.org>
References: <20230131084742.1038135-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131084742.1038135-1-linus.walleij@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 31, 2023 at 09:47:42AM +0100, Linus Walleij wrote:
> If we enable the MMC/SD block layer, use Kconfig to imply the BFQ
> I/O scheduler.
> 
> As all MMC/SD devices are single-queue, this is the scheduler that
> users want so let's be helpful and make sure it gets
> default-selected into a manual kernel configuration. It will still
> need to be enabled at runtime (usually with udev scripts).

NAK.  Nothing requires a specific scheduler here - the scheduler is a
pure user choice.
