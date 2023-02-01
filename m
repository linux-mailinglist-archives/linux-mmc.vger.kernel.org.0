Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574E3686663
	for <lists+linux-mmc@lfdr.de>; Wed,  1 Feb 2023 14:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjBANIV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 1 Feb 2023 08:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBANIU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2023 08:08:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EA0AD24;
        Wed,  1 Feb 2023 05:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0DJ+fu1TOVGN/olgRLBTEaoZLBQeRlRCNJVimqqXr6g=; b=fKrz6P6uzRfZvE1T0iBKvtvueE
        Tjt7XVZ1EGmjLQMUViQaY9asMLuVzvRB6lDU6Gc6r4cKFKRbWKnhem3vgSzUtLpIgdqJ7b/oXNkoj
        c+PwrHPH0+gtVUjSMAGVBOKc9jjdln2DYbhkwuVolyMeL8weu2l3nDczv8W4f4gDGtMZH3++9V0zr
        P4xodfgulDPj3mZCfWwJGmaAg8ayfE6Iy6XpcFN2uYbmuOBOrE8VCEyizg/e4FvBY5MBrRN2ekz5U
        QwzR8umEKSQfoewbVp+Zl7C/EX/nVNFf/Om+wKfAdsp6UN8VftHdt/MCf5vdWEDkqbVioXhwLCG4e
        FnCknPjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNCqY-00BxMx-PB; Wed, 01 Feb 2023 13:08:18 +0000
Date:   Wed, 1 Feb 2023 05:08:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] mmc: core: Imply IOSCHED_BFQ
Message-ID: <Y9pkQth3x9DQb9Kx@infradead.org>
References: <20230131084742.1038135-1-linus.walleij@linaro.org>
 <Y9jY2zsNbSCWluZG@infradead.org>
 <CACRpkda3mk8wkdxWQFev9PrK6bPsxR6qLJo_gXnK+_jaTCFfjg@mail.gmail.com>
 <Y9kVrh9VEz4/T76f@infradead.org>
 <CACRpkdbd73PEAaNYr2cz=pmw7guHK0-hiPCYXgpgQfy-d9TTTQ@mail.gmail.com>
 <Y9kvh42/T9rdqDH9@infradead.org>
 <CACRpkdZ-r_toj3FWuxffSzmO=cDq2Og79R2t48-oAoCE0bT1sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZ-r_toj3FWuxffSzmO=cDq2Og79R2t48-oAoCE0bT1sw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Feb 01, 2023 at 09:18:59AM +0100, Linus Walleij wrote:
> The Kconfig change is mainly about making it available for use,
> for systems with MMC/SD-card drivers.

But that's really not the job of Kconfig.  If you want an I/O schedule
enable it.  I thas absolutely no technical connection to the specific
block driver used.
