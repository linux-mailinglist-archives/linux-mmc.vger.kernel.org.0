Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B2B870B2
	for <lists+linux-mmc@lfdr.de>; Fri,  9 Aug 2019 06:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfHIEem (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 9 Aug 2019 00:34:42 -0400
Received: from void.printf.net ([40.143.112.133]:52768 "EHLO void.printf.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfHIEem (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Aug 2019 00:34:42 -0400
Received: from chris by void.printf.net with local (Exim 4.69)
        (envelope-from <chris@void.printf.net>)
        id 1hvwbu-000CIn-EP; Fri, 09 Aug 2019 05:34:38 +0100
Date:   Fri, 9 Aug 2019 05:34:38 +0100
From:   Chris Ball <chris@printf.net>
To:     Jungseung Lee <js07.lee@gmail.com>
Cc:     Jungseung Lee <js07.lee@samsung.com>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc-utils: feature spec 5.0+, add secure removal type
        fileds to Extended CSD
Message-ID: <20190809043438.GA47266@void.printf.net>
References: <CGME20190807091012epcas1p2d949c05b6dafb0a22f6babe13c5ae9c8@epcas1p2.samsung.com> <20190807091001.2957-1-js07.lee@samsung.com> <20190808224809.GA41025@void.printf.net> <CAPP0e=Ovv9KS4KP6v2g7hoTu50k-4Duvt2BgDYP5vUe4xfsXkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPP0e=Ovv9KS4KP6v2g7hoTu50k-4Duvt2BgDYP5vUe4xfsXkQ@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Fri, Aug 09, 2019 at 11:43:49AM +0900, Jungseung Lee wrote:
> > On Wed, Aug 07, 2019 at 06:10:01PM +0900, Jungseung Lee wrote:
> >> +				printf("by an overwriting the addressed locations"
> >
> > No need for "an", just "by overwriting the addressed locations".
> >
> >> +				printf("using a vendor defined\n");
> >
> > Maybe "using a vendor defined function"?
> All the sentences came from JEDEC specification. (JESD84-B51A)
> Is it more natural to change?

Oh!  I didn't realize.  That's okay, then: thanks, pushed to mmc-utils master.

- Chris.
-- 
Chris Ball   <http://printf.net/>
